import 'package:ninety/models/cctv_system.dart';

class AppUser {
  final String firstName;
  final String lastName;
  final String email;
  final String id;
  final String role;
  final CCTV_System? cctvSystem;

  AppUser({
    required this.lastName,
    required this.email,
    required this.id,
    required this.role,
    required this.firstName,
    required this.cctvSystem,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        lastName: json["lastName"],
        email: json["email"],
        id: json["id"],
        role: json["role"],
        firstName: json["firstName"],
        cctvSystem: json["CCTV_System"] == null
            ? null
            : CCTV_System.fromJson(json["CCTV_System"]));
  }
}
