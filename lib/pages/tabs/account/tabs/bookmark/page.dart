import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/articles/models/article.dart';
import '../../../../../features/articles/widgets/article_list_tile.dart';
import 'state.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Article> articles = ref.watch(
      bookmarkProvider.select((state) => state),
    );

    return articles.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Belum ada artikel yang di bookmark.',
                style: TextStyle(
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView.builder(
            key: const PageStorageKey('bookmark'),
            padding: const EdgeInsets.all(16),
            primary: false,
            shrinkWrap: true,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleListTile(
                article: article,
                showBookmark: true,
              );
            },
          );
  }
}
