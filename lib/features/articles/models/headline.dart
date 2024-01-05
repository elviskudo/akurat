import 'dart:convert';

import 'article.dart';

class HeadlineResponseData {
  final List<Article> list;

  HeadlineResponseData({
    required this.list,
  });

  factory HeadlineResponseData.fromRawJson(String str) =>
      HeadlineResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HeadlineResponseData.fromJson(Map<String, dynamic> json) =>
      HeadlineResponseData(
        list: List<Article>.from(json['list'].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
