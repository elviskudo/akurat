import '../../shared/data/src/fss.dart';
import '../../shared/data/src/hive.dart';
import 'models/user.dart';

class UserRepository {
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
