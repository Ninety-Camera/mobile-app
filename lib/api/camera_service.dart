import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CameraService {
  var _authToken;

  CameraService() {
    _getToken();
  }

  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString(AUTH_TOKEN);
    return _authToken;
  }

  Future<List<Camera>?> getAllCameras(systemId) async {
    _authToken ??= await _getToken();
    try {
      var response = await http.get(
          Uri.parse(
            "$BACKEND_URL/camera/$systemId",
          ),
          headers: {
            HttpHeaders.authorizationHeader: _authToken,
          });

      if (response.statusCode != 200) {
        return null;
      }

      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['status'] == 200) {
        var mainData = decodedResponse['data'] as Map<String, dynamic>?;
        var data = mainData!['cameras'] as List<dynamic>?;
        List<Camera> cameras = data != null
            ? data.map((item) => Camera.fromJson(item)).toList()
            : <Camera>[];
        return cameras;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateSystemStatus(systemId, status) async {
    _authToken ??= await _getToken();
    try {
      var response = await http.put(
          Uri.parse(
            "$BACKEND_URL/cctv/settings/change",
          ),
          body: {
            "systemId": systemId,
            "newStatus": status,
          },
          headers: {
            HttpHeaders.authorizationHeader: _authToken,
          });

      if (response.statusCode != 200) {
        return false;
      }

      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['status'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCameraStatus(camId, systemId, status) async {
    _authToken ??= await _getToken();
    try {
      var response = await http.put(
          Uri.parse(
            "$BACKEND_URL/camera/update",
          ),
          body: {
            "id": camId,
            "systemId": systemId,
            "newStatus": status,
          },
          headers: {
            HttpHeaders.authorizationHeader: _authToken,
          });

      if (response.statusCode != 200) {
        return false;
      }

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
