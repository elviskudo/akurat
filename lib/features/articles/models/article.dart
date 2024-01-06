import 'dart:convert';

import 'package:intl/intl.dart';

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
  String? sectionAlias;
  ArticleSite? site;
  String? pageviews;

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
    this.pageviews,
    this.sectionAlias,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        contentType: json['content_type'] ?? '',
        description: json['description'] ?? '',
        id: json['id'],
        isVideoContent: json['is_video_content'] == 1 ? true : false,
        photoUrl: json['photo_url'] ?? '',
        publishedDate: DateFormat('d MMMM y, HH:mm WIB').format(
          DateTime.parse(json['published_date']),
        ),
        section: json['section'] != null
            ? ArticleSection.fromJson(json['section'])
            : null,
        sectionAlias: json['section'] != null ? json['section']['name'] : null,
        site: json['site'] != null ? ArticleSite.fromJson(json['site']) : null,
        thumbUrl: json['thumb_url'] ?? '',
        shortUrl: json['short_url'] ?? '',
        title: json['title'],
        url: json['url'],
        pageviews: json['pageviews'] != null
            ? NumberFormat.compact(
                locale: 'id_ID',
              ).parse(json['pageviews']).toString()
            : null,
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
        'pageviews': pageviews != null
            ? NumberFormat.compact(locale: 'id_ID').format(
                int.parse(
                  pageviews!.replaceAll(RegExp(r'[^0-9]'), ''),
                ),
              )
            : null,
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

class ArticleResponseData {
  final List<Article> list;

  ArticleResponseData({
    required this.list,
  });

  factory ArticleResponseData.fromRawJson(String str) =>
      ArticleResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleResponseData.fromJson(Map<String, dynamic> json) {
    // check if json['list] is array or object
    final hasLatest = json['list'] is Map<String, dynamic>;

    return ArticleResponseData(
      list: List<Article>.from(
        hasLatest
            ? json['list']['latest'].map((x) => Article.fromJson(x))
            : json['list'].map((x) => Article.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
