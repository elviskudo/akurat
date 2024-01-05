import 'dart:convert';

class Article {
  final String description;
  final int id;
  final bool isVideoContent;
  final String photoUrl;
  final String publishedDate;
  final String thumbUrl;
  final String title;
  final String url;
  String? contentType;
  String? shortUrl;
  ArticleSection? section;
  ArticleSite? site;

  Article({
    required this.description,
    required this.id,
    required this.isVideoContent,
    required this.photoUrl,
    required this.publishedDate,
    required this.thumbUrl,
    required this.title,
    required this.url,
    this.contentType,
    this.shortUrl,
    this.section,
    this.site,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        contentType: json['content_type'],
        description: json['description'],
        id: json['id'],
        isVideoContent: json['is_video_content'] == 1 ? true : false,
        photoUrl: json['photo_url'],
        publishedDate: json['published_date'],
        section: json['section'] != null
            ? ArticleSection.fromJson(json['section'])
            : null,
        site: json['site'] != null ? ArticleSite.fromJson(json['site']) : null,
        thumbUrl: json['thumb_url'],
        shortUrl: json['short_url'],
        title: json['title'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'content_type': contentType,
        'description': description,
        'id': id,
        'is_video_content': isVideoContent ? 1 : 0,
        'photo_url': photoUrl,
        'published_date': publishedDate,
        'thumb_url': thumbUrl,
        'title': title,
        'url': url,
        'short_url': shortUrl,
        'section': section?.toJson(),
        'site': site?.toJson(),
      };
}

class ArticleSection {
  final String alias;
  final int id;
  final String name;

  ArticleSection({
    required this.alias,
    required this.id,
    required this.name,
  });

  factory ArticleSection.fromRawJson(String str) =>
      ArticleSection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleSection.fromJson(Map<String, dynamic> json) => ArticleSection(
        alias: json['alias'],
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'alias': alias,
        'id': id,
        'name': name,
      };
}

class ArticleSite {
  final String alias;
  final int id;
  final String name;
  final String url;

  ArticleSite({
    required this.alias,
    required this.id,
    required this.name,
    required this.url,
  });

  factory ArticleSite.fromRawJson(String str) =>
      ArticleSite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleSite.fromJson(Map<String, dynamic> json) => ArticleSite(
        alias: json['alias'],
        id: json['id'],
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'alias': alias,
        'id': id,
        'name': name,
        'url': url,
      };
}
