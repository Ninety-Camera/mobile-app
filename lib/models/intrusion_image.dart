class IntrusionImage {
  final String link;
  final String intrusionId;
  IntrusionImage({
    required this.link,
    required this.intrusionId,
  });

  factory IntrusionImage.fromJson(Map<String, dynamic> json) {
    return IntrusionImage(
      link: json["image"],
      intrusionId: json["intrusionId"],
    );
  }
}
