class ArticleModel {
  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String url;

  ArticleModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
      summary: json['summary'] ?? '',
      url: json['url'] ?? '',
    );
  }
}