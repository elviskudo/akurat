import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '(tab)/home.dart';
import '(tab)/topics.dart';
import '../features/topics/topics_view.dart';
import '../shared/widgets/app_shell.dart';
import '_app_state.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTab currentTab = ref.watch(
      appNotifierProvider.select((state) => state.currentTab),
    );

    return AppShell(
      appBar: AppBar(
        title: WebsafeSvg.asset(
          'assets/logo.svg',
          height: 32.0,
        ),
        centerTitle: true,
        bottom: const TopicsTabBar(),
      ),
      child: IndexedStack(
        index: currentTab.index,
        children: const [
          HomeTab(),
          TopicsTab(),
        ],
      ),
    );
  }
}
