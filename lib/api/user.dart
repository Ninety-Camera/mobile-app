import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  var _authToken;

  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString(AUTH_TOKEN);
    return _authToken;
  }

  Future<AppUser?> register({email, password, firstName, lastName}) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$BACKEND_URL/user/register",
        ),
        body: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName
        },
      );

      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == 201) {
        var data = decodedResponse['data'] as Map<String, dynamic>?;
        var user = data!["user"];
        final prefs = await SharedPreferences.getInstance();
        _authToken = "Bearer " + data["token"];
        await prefs.setString(AUTH_TOKEN, "Bearer " + data["token"]);
        return AppUser.fromJson(user);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<AppUser?> signIn(email, password) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$BACKEND_URL/user/login",
        ),
        body: {
          "email": email,
          "password": password,
        },
      );
      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == 200) {
        var data = decodedResponse['data'] as Map<String, dynamic>?;
        var user = data!["user"];
        final prefs = await SharedPreferences.getInstance();
        _authToken = "Bearer " + data["token"];
        await prefs.setString(AUTH_TOKEN, "Bearer " + data["token"]);
        return AppUser.fromJson(user);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkUserMobileDevice(userId) async {
    _authToken ??= await _getToken();
    try {
      var response = await http.get(
        Uri.parse(
          "$BACKEND_URL/user/mobile/check/$userId",
        ),
        headers: {
          HttpHeaders.authorizationHeader: _authToken,
        },
      );
      var decodedResponse = jsonDecode(response.body);
      print("Response is: " + decodedResponse.toString());
      if (decodedResponse['status'] == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AppUser?> resetPassword(email) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$BACKEND_URL/user/reset",
        ),
        body: {
          "email": email,
        },
      );
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['status'] == 200) {
        var data = decodedResponse['data'] as Map<String, dynamic>?;
        var user = data!["user"];
        return AppUser.fromJson(user);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> changePassword(otp, password, userId) async {
    try {
      var response = await http.put(
        Uri.parse(
          "$BACKEND_URL/user/reset",
        ),
        body: {"password": password, "userId": userId, "token": otp},
      );
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['status'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
