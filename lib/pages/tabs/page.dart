import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/page.dart';
import 'home/state.dart';
import 'topics/slug/page.dart';

class IndexPage extends ConsumerWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTab currentTab = ref.watch(
      homeStateNotifierProvider.select((state) => state.currentTab),
    );

    String tag = ref.watch(
      homeStateNotifierProvider.select((state) => state.tag ?? ''),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: IndexedStack(
        index: currentTab.index,
        children: [
          const HomePage(),
          TopicsDetailPage(tag: tag),
        ],
      ),
    );
  }
}
