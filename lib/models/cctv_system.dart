class CCTV_System {
  final String id;
  String status;
  final int cameraCount;

  CCTV_System({
    required this.id,
    required this.cameraCount,
    required this.status,
  });

  factory CCTV_System.fromJson(Map<String, dynamic> json) {
    return CCTV_System(
      id: json["id"],
      cameraCount: json["cameraCount"],
      status: json["status"],
    );
  }
}
