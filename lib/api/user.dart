import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/user.dart';

class UserService {
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
        return AppUser.fromJson(user);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> resetPassword(email) async {
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
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
