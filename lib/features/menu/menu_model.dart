import 'dart:convert';

class MenuResponseData {
  final List<Menu> list;

  MenuResponseData({required this.list});

  factory MenuResponseData.fromRawJson(String str) =>
      MenuResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuResponseData.fromJson(Map<String, dynamic> json) =>
      MenuResponseData(
        list: List<Menu>.from(json['list'].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Menu {
  final String title;
  final String alias;
  final String description;
  final int id;
  final String keyword;
  final String name;
  List<Menu>? child;
  String? iconUrl;
  String? photoUrl;

  Menu({
    required this.title,
    required this.alias,
    required this.description,
    required this.id,
    required this.keyword,
    required this.name,
    this.child,
    this.iconUrl,
    this.photoUrl,
  });

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        alias: json['alias'],
        child: json['child'] == null
            ? null
            : List<Menu>.from(json['child'].map((x) => Menu.fromJson(x))),
        description: json['description'],
        iconUrl: json['icon_url'],
        id: json['id'],
        keyword: json['keyword'],
        name: json['name'],
        photoUrl: json['photo_url'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'alias': alias,
        'child': child == null
            ? null
            : List<dynamic>.from(child!.map((x) => x.toJson())),
        'description': description,
        'icon_url': iconUrl,
        'id': id,
        'keyword': keyword,
        'name': name,
        'photo_url': photoUrl,
        'title': title,
      };
}
