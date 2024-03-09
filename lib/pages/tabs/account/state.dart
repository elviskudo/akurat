import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/signin/models/user.dart';
import '../../../features/signin/user_repository.dart';

class AccountNotifier extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  void refresh() async {
    final user = await UserRepository.getSavedUser();
    state = user;
  }

  void login(dynamic content) {
    print(content);
    state = User.mock();
  }

  void logout() async {
    await UserRepository.removeUser();
    state = null;
  }
}

final accountProvider = NotifierProvider<AccountNotifier, User?>(
  () => AccountNotifier(),
);
