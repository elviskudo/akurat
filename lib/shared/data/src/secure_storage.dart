import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _instance = FlutterSecureStorage();
  static FlutterSecureStorage get instance => _instance;

  static Future<void> write(String key, String value) async {
    await instance.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await instance.read(key: key);
  }

  static Future<void> delete(String key) async {
    await instance.delete(key: key);
  }
}
