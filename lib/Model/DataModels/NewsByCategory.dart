import 'package:meta/meta.dart';
import 'dart:convert';

NewsByCategory newsByCategoryFromJson(String str) => NewsByCategory.fromJson(json.decode(str));

String newsByCategoryToJson(NewsByCategory data) => json.encode(data.toJson());

class NewsByCategory {
  NewsByCategory({
    @required this.status,
    @required this.totalResults,
    @required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory NewsByCategory.fromJson(Map<String, dynamic> json) => NewsByCategory(
    status: json["status"] == null ? null : json["status"],
    totalResults: json["totalResults"] == null ? null : json["totalResults"],
    articles: json["articles"] == null ? null : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "totalResults": totalResults == null ? null : totalResults,
    "articles": articles == null ? null : List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Article({
    @required this.source,
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
    author: json["author"] == null ? null : json["author"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    url: json["url"] == null ? null : json["url"],
    urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    content: json["content"] == null ? null : json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source == null ? null : source.toJson(),
    "author": author == null ? null : author,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "url": url == null ? null : url,
    "urlToImage": urlToImage == null ? null : urlToImage,
    "publishedAt": publishedAt == null ? null : publishedAt.toIso8601String(),
    "content": content == null ? null : content,
  };
}

class Source {
  Source({
    @required this.id,
    @required this.name,
  });

  final dynamic id;
  final String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name == null ? null : name,
  };
}
