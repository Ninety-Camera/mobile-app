import 'package:ninety/models/cctv_system.dart';
import 'package:ninety/models/intrusion_image.dart';
import 'package:test/test.dart';

void main() {
  test('Intrusion image class tests', () {
    final intrusionImage = IntrusionImage(link: "link", intrusionId: "123");
    expect(intrusionImage.link, "link");
    expect(intrusionImage.intrusionId, "123");
  });
}
