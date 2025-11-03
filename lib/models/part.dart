class Part {
  final int partId;
  final int? categoryId;
  final String? fullDescription;
  final String? partImage;
  final String partName;
  final String? shortDescription;
  final String? videoLink;
  final String? vrLink;
  final int progress; // Added for tracking learning progress

  Part({
    required this.partId,
    this.categoryId,
    this.fullDescription,
    this.partImage,
    required this.partName,
    this.shortDescription,
    this.videoLink,
    this.vrLink,
    this.progress = 0,
  });
}