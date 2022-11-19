import 'package:ninety/models/intrusion_image.dart';
import 'package:ninety/models/intrusion_video.dart';

class Intrusion {
  final String id;
  final String occuredAt;
  final List<IntrusionImage> intrusionImages;
  final IntrusionVideo? intrusionVideo;

  Intrusion({
    required this.id,
    required this.occuredAt,
    required this.intrusionImages,
    required this.intrusionVideo,
  });

  factory Intrusion.fromJson(Map<String, dynamic> json) {
    var intrusionImages = json["Intrusion_Image"] as List<dynamic>?;
    List<IntrusionImage> images = intrusionImages != null
        ? intrusionImages.map((item) => IntrusionImage.fromJson(item)).toList()
        : <IntrusionImage>[];
    return Intrusion(
      id: json["id"],
      occuredAt: json["occuredAt"],
      intrusionImages: images,
      intrusionVideo: json["Intrusion_Video"] != null
          ? IntrusionVideo.fromJson(json["Intrusion_Video"])
          : null,
    );
  }
}
