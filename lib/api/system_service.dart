import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/cctv_system.dart';
import 'package:ninety/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class SystemService {
  var _authToken;

  SystemService() {
    _getToken();
  }

  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString(AUTH_TOKEN);
    return _authToken;
  }

  Future<AppUser?> susbscribeForSystem(
      AppUser appUser, systemId, deviceId) async {
    _authToken ??= await _getToken();
    try {
      var response = await http.post(
          Uri.parse(
            "$BACKEND_URL/user/mobile/register",
          ),
          body: {
            "id": deviceId,
            "systemId": systemId,
            "ownerId": appUser.id
          },
          headers: {
            HttpHeaders.authorizationHeader: _authToken,
          });

      if (response.statusCode != 200) {
        return null;
      }

      var decodedResponse = jsonDecode(response.body) as Map<String, dynamic>?;
      if (decodedResponse!['status'] == 201) {
        var mainData = decodedResponse['data'] as Map<String, dynamic>?;
        var data = mainData!['system'] as Map<String, dynamic>?;
        appUser.cctvSystem = CCTV_System.fromJson(data!);
        return appUser;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
