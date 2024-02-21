import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../features/articles/article_repository.dart';
import '../../../../features/articles/models/article.dart';
import '../../../../features/articles/widgets/article_list_tile.dart';
import '../../../../features/articles/widgets/article_list_tile_loading.dart';

enum PageType { search, tag }

class TopicsDetailPage extends StatefulWidget {
  const TopicsDetailPage({
    super.key,
    required this.tag,
    this.type = PageType.tag,
  });

  final String tag;
  final PageType type;

  @override
  State<TopicsDetailPage> createState() => _TopicsDetailPageState();
}

class _TopicsDetailPageState extends State<TopicsDetailPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final query = ArticleRepository.getArticlesByTag(widget.tag);
    if (_isBottom && query.state.status != QueryStatus.loading) {
      query.getNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteQueryBuilder<List<Article>, int>(
      query: widget.type == PageType.tag
          ? ArticleRepository.getArticlesByTag(widget.tag)
          : ArticleRepository.getArticlesByKeyword(widget.tag),
      builder: (context, state, query) {
        final articles = state.data?.expand((e) => e).toList();

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(top: 24.0),
            ),
            if (state.status == QueryStatus.error)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(
                      state.error is SocketException
                          ? 'Tidak ada koneksi internet.'
                          : 'Terjadi kesalahan. Silahkan coba lagi.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            if (articles != null) ...[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final article = articles[index];
                      return ArticleListTile(article: article);
                    },
                    childCount: articles.length,
                  ),
                ),
              ),
            ],
            if (state.status == QueryStatus.success && (articles ?? []).isEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Text(
                      'Tidak dapat menemukan artikel.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            if (state.hasReachedMax)
              const SliverPadding(
                padding: EdgeInsets.only(top: 24.0),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text('Semua artikel telah ditampilkan.'),
                  ),
                ),
              ),
            if (state.status == QueryStatus.loading)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const ArticleListTileLoading(),
                    childCount: 10,
                  ),
                ),
              ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 24,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
            )
          ],
        );
      },
    );
  }
}
