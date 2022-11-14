import 'dart:convert';
import 'dart:io';

import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/intrusion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IntrusionService {
  var _authToken;

  IntrusionService() {
    _getToken();
  }

  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString(AUTH_TOKEN);
    return _authToken;
  }

  Future<Intrusion?> getLatestIntrusion(systemId) async {
    _authToken ??= await _getToken();
    try {
      var response = await http.get(
          Uri.parse(
            "$BACKEND_URL/intrusion/latest/$systemId",
          ),
          headers: {
            HttpHeaders.authorizationHeader: _authToken,
          });

      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['status'] == 200) {
        var data = decodedResponse['data'] as Map<String, dynamic>?;
        var intrusion = data!["intrusion"];
        return Intrusion.fromJson(intrusion);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
