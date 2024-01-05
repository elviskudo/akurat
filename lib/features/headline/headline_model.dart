import 'dart:convert';

import '../shared/article/article_model.dart';

class Headline {
  final List<Article> list;

  Headline({
    required this.list,
  });

  factory Headline.fromRawJson(String str) =>
      Headline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
        list: List<Article>.from(json['list'].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
