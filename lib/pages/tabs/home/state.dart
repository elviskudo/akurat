import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppTab {
  home,
  topics,
}

@immutable
class HomeState {
  final int topicsTabIndex;
  final AppTab currentTab;
  final String? tag;

  const HomeState({
    required this.topicsTabIndex,
    required this.currentTab,
    this.tag,
  });

  HomeState copyWith({
    int? topicsTabIndex,
    AppTab? currentTab,
    String? tag,
  }) {
    return HomeState(
      topicsTabIndex: topicsTabIndex ?? this.topicsTabIndex,
      currentTab: currentTab ?? this.currentTab,
      tag: tag ?? this.tag,
    );
  }

  factory HomeState.reset() {
    return const HomeState(
      topicsTabIndex: 0,
      currentTab: AppTab.home,
      tag: null,
    );
  }
}

class HomeStateNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState.reset();
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

final homeStateNotifierProvider =
    NotifierProvider<HomeStateNotifier, HomeState>(
  () => HomeStateNotifier(),
);
