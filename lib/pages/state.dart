import 'package:flutter_riverpod/flutter_riverpod.dart';

class PagesNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changePage(int index) {
    state = index;
  }

  void dispose() {
    state = 0;
  }
}

final pagesProvider = NotifierProvider<PagesNotifier, int>(
  () => PagesNotifier(),
);
