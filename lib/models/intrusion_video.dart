class IntrusionVideo {
  final String videoLink;
  final String intrusionId;

  IntrusionVideo({
    required this.videoLink,
    required this.intrusionId,
  });

  factory IntrusionVideo.fromJson(Map<String, dynamic> json) {
    return IntrusionVideo(
      videoLink: json["video"],
      intrusionId: json["intrusionId"],
    );
  }
}
