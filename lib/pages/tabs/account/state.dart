import 'package:flutter/material.dart';
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

  void login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    await UserRepository.login(email: email, password: password).then((user) {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Proses autentikasi gagal. Pastikan data yang Anda masukkan sudah benar.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }

      state = user;

      Navigator.of(context).pop();
    });
  }

  void logout() async {
    await UserRepository.removeUser();
    state = null;
  }
}

final accountProvider = NotifierProvider<AccountNotifier, User?>(
  () => AccountNotifier(),
);
