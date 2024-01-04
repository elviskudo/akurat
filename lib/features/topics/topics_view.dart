import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'topics_repository.dart';
import 'widgets/topics_chip_loading.dart';

class TopicsTabBar extends StatefulWidget implements PreferredSizeWidget {
  const TopicsTabBar({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  State<TopicsTabBar> createState() => _TopicsTabBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopicsTabBarState extends State<TopicsTabBar> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    selected: currentIndex == 0,
                    onSelected: (bool value) {
                      updateIndex(0);
                    },
                  ),
                );
              }

              return FilterChip(
                showCheckmark: false,
                label: Text(state.data![index].title),
                selected: currentIndex == index,
                onSelected: (bool value) {
                  updateIndex(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}
