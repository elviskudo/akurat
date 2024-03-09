// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../shared/data/src/fss.dart';
import '../../shared/data/src/hive.dart';
import 'models/user.dart';

class UserRepository {
  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    final data = FormData.fromMap({
      'email': email,
      'password': password,
    });

    final client = Dio(
      BaseOptions(
        baseUrl: 'http://sso.imerzone.com',
        contentType: 'application/x-www-form-urlencoded',
      ),
    )..httpClientAdapter = DefaultHttpClientAdapter(
        validateCertificate: (certificate, host, port) => true,
      );

    final res = await client.post('/api/auth/login', data: data);

    if (res.statusCode != 200) return null;
    final user = User.fromJson(res.data['user']);
    await saveUser(user);

    return user;
  }

  static Future<User?> getSavedUser() async {
    final userId = await SecureStorage.read('x-user-id');
    if (userId != null) return HiveStore.getEntity<User>(userId);
    return null;
  }

  static Future<void> saveUser(User user) async {
    await SecureStorage.write('x-user-id', user.key);
    await HiveStore.saveEntity(user);
  }

  static Future<void> removeUser() async {
    final userId = await SecureStorage.read('x-user-id');

    if (userId == null) throw Exception('User not found');

    await SecureStorage.delete('x-user-id');
    await HiveStore.deleteEntity(userId);
  }
}
