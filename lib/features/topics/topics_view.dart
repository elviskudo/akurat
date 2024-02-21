import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../pages/tabs/home/state.dart';
import 'topics_repository.dart';
import 'widgets/topics_chip_loading.dart';

class TopicsTabBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopicsTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onTap(WidgetRef ref, {required int index, String? tag}) {
    ref
        .read(homeStateNotifierProvider.notifier)
        .setCurrentTopicsTabIndex(index, tag: tag);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentTabIndex = ref.watch(
      homeStateNotifierProvider.select((state) => state.topicsTabIndex),
    );

    return QueryBuilder(
      query: TopicsRepository.getTopics(),
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: kToolbarHeight,
          child: ListView.separated(
            primary: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 8.0);
            },
            itemCount: state.data?.length ?? 10,
            itemBuilder: (BuildContext context, int index) {
              if (state.status == QueryStatus.loading) {
                return const TopicsChipLoading();
              }

              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    showCheckmark: false,
                    label: const Icon(LucideIcons.home, size: 22.0),
                    selected: currentTabIndex == 0,
                    onSelected: (bool value) {
                      _onTap(ref, index: 0);
                    },
                  ),
                );
              }

              return FilterChip(
                showCheckmark: false,
                label: Text(state.data![index].title),
                selected: currentTabIndex == index,
                onSelected: (bool value) {
                  _onTap(
                    ref,
                    index: index,
                    tag: state.data![index].title,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
