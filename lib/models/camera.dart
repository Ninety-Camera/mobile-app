import 'package:ninety/models/user.dart';

class Camera {
  final String camId;
  final String name;
  String status;

  Camera({
    required this.camId,
    required this.name,
    required this.status,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      camId: json["id"],
      name: json["name"],
      status: json["status"],
    );
  }
}
