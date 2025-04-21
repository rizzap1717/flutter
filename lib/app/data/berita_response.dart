class News {
  bool? success;
  String? message;
  List<Data>? data;

  News({
    this.success,
    this.message,
    this.data,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e))
          .toList(),
    );
  }
}

class Data {
  int? id;
  String? title;
  String? content;
  String? date;
  String? newsPicture;
  String? authors;

  Data({
    this.id,
    this.title,
    this.content,
    this.date,
    this.newsPicture,
    this.authors,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      newsPicture: json['news_picture'],
      authors: json['authors'],
    );
  }
}
