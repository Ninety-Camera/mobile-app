import 'package:ninety/models/cctv_system.dart';
import 'package:test/test.dart';

void main() {
  test('CCTV system class tests', () {
    final cctvSystem =
        CCTV_System(id: "123", cameraCount: 18, status: "RUNNING");

    expect(cctvSystem.id, "123");
    expect(cctvSystem.cameraCount, 18);
    expect(cctvSystem.status, "RUNNING");
  });
}
