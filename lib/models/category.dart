class Category {
  final int categoryId;
  final String? categoryImage;
  final String categoryName;
  final String? categoryShortDescription;
  final int? levelId;
  final int? teacherId;

  Category({
    required this.categoryId,
    this.categoryImage,
    required this.categoryName,
    this.categoryShortDescription,
    this.levelId,
    this.teacherId,
  });
}