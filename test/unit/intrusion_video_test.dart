import 'package:ninety/models/intrusion_video.dart';
import 'package:test/test.dart';

void main() {
  test('Intrusion video class tests', () {
    final intrusionVideo =
        IntrusionVideo(videoLink: "link", intrusionId: "123");
    expect(intrusionVideo.videoLink, "link");
    expect(intrusionVideo.intrusionId, "123");
  });
}
