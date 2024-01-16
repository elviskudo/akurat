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
  final String? tag;

  const AppState({
    required this.topicsTabIndex,
    required this.currentTab,
    this.tag,
  });

  AppState copyWith({
    int? topicsTabIndex,
    AppTab? currentTab,
    String? tag,
  }) {
    return AppState(
      topicsTabIndex: topicsTabIndex ?? this.topicsTabIndex,
      currentTab: currentTab ?? this.currentTab,
      tag: tag ?? this.tag,
    );
  }

  factory AppState.reset() {
    return const AppState(
      topicsTabIndex: 0,
      currentTab: AppTab.home,
      tag: null,
    );
  }
}

class AppNotifier extends Notifier<AppState> {
  @override
  AppState build() {
    return AppState.reset();
  }

  void setCurrentTopicsTabIndex(int index, {String? tag}) {
    if (index == 0) {
      state = state.copyWith(
        topicsTabIndex: index,
        currentTab: AppTab.home,
        tag: null,
      );
      return;
    }

    state = state.copyWith(
      topicsTabIndex: index,
      currentTab: AppTab.topics,
      tag: tag,
    );
  }
}

final appNotifierProvider = NotifierProvider<AppNotifier, AppState>(
  () => AppNotifier(),
);
