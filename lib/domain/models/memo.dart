class Memo {
  final String id;
  final String title;
  final String content;
  final String categoryId;
  final DateTime createdAt;

  Memo({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.createdAt,
  });
}
