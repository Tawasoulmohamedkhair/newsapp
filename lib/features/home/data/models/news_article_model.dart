import 'package:newsapp/features/home/domain/entities/news_article_entity.dart';

class NewsArticleModel extends NewsArticleEntity {
  const NewsArticleModel({
    super.author,
    required super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      author: json['author'] as String?,
      title: json['title'] ?? '',
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,

      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString())
          : null,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,

      'publishedAt': publishedAt?.toIso8601String(),
      'content': content,
    };
  }

  NewsArticleEntity toEntity() {
    return NewsArticleEntity(
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
