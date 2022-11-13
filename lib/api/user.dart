import 'package:http/http.dart' as http;
import 'package:ninety/constants/constants.dart';

Future<http.Response> signIn(email, password) {
  return http.post(
    Uri.parse(
      "$BACKEND_URL/user/login",
    ),
    body: {
      "email": email,
      "password": password,
    },
  );
}
