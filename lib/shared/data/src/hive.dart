import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/articles/models/article.dart';
import '../../../features/signin/models/user.dart';

class HiveStore {
  static const String box = 'co_akurat_mobile_box';

  static List<T> getAllEntities<T extends LocalEntity>() {
    final data = Hive.box<String>(box).values.map((e) {
      return LocalEntity.fromJson(T, Map<String, dynamic>.from(jsonDecode(e)));
    }).toList();
    return List<T>.from(data);
  }

  static T? getEntity<T extends LocalEntity>(String id) {
    final dataLocal = Hive.box<String>(box).get(id);
    if (dataLocal == null) return null;
    return LocalEntity.fromJson(
        T, Map<String, dynamic>.from(jsonDecode(dataLocal))) as T;
  }

  static Future<void> saveEntity<T extends LocalEntity>(T entity) async {
    await Hive.box<String>(box).put(entity.key, jsonEncode(entity.toJson()));
  }

  static Future<void> deleteEntity(String key) async {
    await Hive.box<String>(box).delete(key);
  }
}

abstract class LocalEntity {
  final String key;

  LocalEntity(this.key);

  factory LocalEntity.fromJson(Type type, Map<String, dynamic> e) {
    switch (type) {
      case Article:
        return Article.fromJson(e);
      case User:
        return User.fromJson(e);
      default:
        throw Exception('Type not found');
    }
  }

  Map<String, dynamic> toJson();
}
