import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../pages/state.dart';
import '../../../pages/tabs/topics/slug/page.dart';
import '../topics_repository.dart';

class TopicsSearchDelegate extends SearchDelegate<String> {
  TopicsSearchDelegate({required this.ref});

  final WidgetRef ref;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
        ref.read(pagesProvider.notifier).changePage(0);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return TopicsDetailPage(tag: query, type: PageType.search);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: TopicsRepository.recentSearches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final searches = snapshot.data!;
          return ListView.builder(
            itemCount: searches.length,
            itemBuilder: (context, index) {
              final keyword = searches[index];
              return ListTile(
                leading: const Icon(LucideIcons.history),
                title: Text(keyword),
                onTap: () {
                  TopicsRepository.addRecentSearch(keyword);
                  close(context, keyword);
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
