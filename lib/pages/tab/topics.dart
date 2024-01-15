import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_app_state.dart';

class TopicsPage extends ConsumerWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(
      appNotifierProvider.select((state) => state.topicsTabIndex),
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Topics $currentIndex'),
      ),
    );
  }
}
