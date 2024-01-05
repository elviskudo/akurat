import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppTab {
  home,
  topics,
}

@immutable
class AppState {
  final int topicsTabIndex;
  final AppTab currentTab;

  const AppState({
    required this.topicsTabIndex,
    required this.currentTab,
  });

  AppState copyWith({
    int? topicsTabIndex,
    AppTab? currentTab,
  }) {
    return AppState(
      topicsTabIndex: topicsTabIndex ?? this.topicsTabIndex,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  factory AppState.reset() {
    return const AppState(
      topicsTabIndex: 0,
      currentTab: AppTab.home,
    );
  }
}

class AppNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    return AppState.reset();
  }

  void setCurrentTopicsTabIndex(int index) {
    if (index == 0) {
      state = state.copyWith(
        topicsTabIndex: index,
        currentTab: AppTab.home,
      );
      return;
    }

    state = state.copyWith(
      topicsTabIndex: index,
      currentTab: AppTab.topics,
    );
  }
}

final appNotifierProvider = NotifierProvider<AppNotifier, AppState>(
  () => AppNotifier(),
);
