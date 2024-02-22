import 'dart:convert';

import 'package:intl/intl.dart';

import 'article.dart';

class ArticleDetail {
  final ArticleAuthor author;
  final String content;
  final String description;
  final int id;
  final List<ArticleContentPhoto> photo;
  final String photoUrl;
  final String publishedDate;
  final List<Article> related;
  ArticleSection? section;
  final ArticleSite site;
  final List<Tag> tag;
  final String thumbUrl;
  final String title;
  final String url;

  ArticleDetail({
    required this.author,
    required this.content,
    required this.description,
    required this.id,
    required this.photo,
    required this.photoUrl,
    required this.publishedDate,
    required this.related,
    this.section,
    required this.site,
    required this.tag,
    required this.thumbUrl,
    required this.title,
    required this.url,
  });

  factory ArticleDetail.fromRawJson(String str) =>
      ArticleDetail.fromJson(json.decode(str));

  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    String html(String str) {
      final readOthers = RegExp(r'<strong class="read__others">.*?</strong>');
      final imgTemplate = RegExp(r'<p><strong> <!--img\d+--> </strong></p>');

      return str.replaceAll(readOthers, '').replaceAll(imgTemplate, '');
    }

    String formatDate(String dateString) {
      return DateFormat('d MMMM y, HH:mm WIB').format(
        DateTime.parse(dateString),
      );
    }

    return ArticleDetail(
      author: ArticleAuthor.fromJson(json['published_by']),
      content: html(json['content']),
      description: json['description'],
      id: json['id'],
      photo: List<ArticleContentPhoto>.from(
        json['photo'].map((x) => ArticleContentPhoto.fromJson(x)),
      ),
      photoUrl: json['photo_url'],
      publishedDate: formatDate(json['published_date']),
      related: List<Article>.from(
        json['related'].map((x) => Article.fromJson(x)),
      ),
      section: json['section'] != null
          ? ArticleSection.fromJson(json['section'])
          : null,
      site: ArticleSite.fromJson(json['site']),
      tag: List<Tag>.from(json['tag'].map((x) => Tag.fromJson(x))),
      thumbUrl: json['thumb_url'],
      title: json['title'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'content': content,
        'description': description,
        'id': id,
        'photo': List<dynamic>.from(photo.map((x) => x.toJson())),
        'photo_url': photoUrl,
        'published_date': publishedDate,
        'related': List<dynamic>.from(related.map((x) => x.toJson())),
        'section': section?.toJson(),
        'site': site.toJson(),
        'tag': List<dynamic>.from(tag.map((x) => x.toJson())),
        'thumb_url': thumbUrl,
        'title': title,
        'url': url,
      };

  Article toArticle() {
    return Article(
      'article-$id',
      title: title,
      description: description,
      id: id,
      isVideoContent: false,
      photoUrl: photoUrl,
      publishedDate: publishedDate,
      thumbUrl: thumbUrl,
      url: url,
      section: section,
      site: site,
    );
  }
}

class ArticleAuthor {
  final String email;
  final int id;
  final String name;

  ArticleAuthor({
    required this.email,
    required this.id,
    required this.name,
  });

  factory ArticleAuthor.fromRawJson(String str) =>
      ArticleAuthor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleAuthor.fromJson(Map<String, dynamic> json) => ArticleAuthor(
        email: json['email'],
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': id,
        'name': name,
      };
}

class ArticleContentPhoto {
  final String author;
  final String caption;
  final String credit;
  final String src;

  ArticleContentPhoto({
    required this.author,
    required this.caption,
    required this.credit,
    required this.src,
  });

  factory ArticleContentPhoto.fromRawJson(String str) =>
      ArticleContentPhoto.fromJson(json.decode(str));

  factory ArticleContentPhoto.fromJson(Map<String, dynamic> json) =>
      ArticleContentPhoto(
        author: json['author'],
        caption: json['caption'],
        credit: json['credit'],
        src: json['src'],
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'caption': caption,
        'credit': credit,
        'src': src,
      };
}

class Tag {
  final int id;
  final String name;

  Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class ArticleDetailResponseData {
  final ArticleDetail detail;

  ArticleDetailResponseData({
    required this.detail,
  });

  factory ArticleDetailResponseData.fromRawJson(String str) =>
      ArticleDetailResponseData.fromJson(json.decode(str));

  factory ArticleDetailResponseData.fromJson(Map<String, dynamic> json) =>
      ArticleDetailResponseData(
        detail: ArticleDetail.fromJson(json['detail']),
      );

  Map<String, dynamic> toJson() => {
        'detail': detail.toJson(),
      };
}
