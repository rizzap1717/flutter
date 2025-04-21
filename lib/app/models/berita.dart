class NewsModel {
  final int id;
  final String? title;
  final String? content;
  final String? date;
  final String? newsPicture;
  final String? authors;
  final String? createdAt;
  final String? updatedAt;

  NewsModel({
    required this.id,
    this.title,
    this.content,
    this.date,
    this.newsPicture,
    this.authors,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? 0,
      title: json['title'],
      content: json['content'],
      date: json['date'],
      newsPicture: json['news_picture'],
      authors: json['authors'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'news_picture': newsPicture,
      'authors': authors,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
