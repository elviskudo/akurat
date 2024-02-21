import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../features/articles/article_repository.dart';
import '../../../../features/articles/widgets/article_list_tile.dart';
import '../../../../features/articles/widgets/article_list_tile_loading.dart';

class LatestList extends StatelessWidget {
  const LatestList({super.key});

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: ArticleRepository.getLatest(),
      builder: (context, state) {
        if (state.status == QueryStatus.loading || state.data == null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(3, (index) {
              return const ArticleListTileLoading();
            }),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: state.data!.map((e) {
            return ArticleListTile(article: e);
          }).toList(),
        );
      },
    );
  }
}
