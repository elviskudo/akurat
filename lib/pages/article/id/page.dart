import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../features/articles/article_repository.dart';
import '../../../features/articles/widgets/article_list_tile.dart';
import '../../tabs/home/widgets/home_tab_section.dart';
import '../tag/page.dart';
import 'widget/article_detail_app_bar.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: ArticleRepository.getDetail(id),
      builder: (context, state) {
        return Scaffold(
          body: state.status == QueryStatus.loading || state.data == null
              ? const Center(child: CircularProgressIndicator())
              : NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      ArticleDetailAppBar(
                        shouldShowTitle: innerBoxIsScrolled,
                        articleDetail: state.data!,
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.data!.author.name} - ${state.data!.publishedDate}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.data!.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '"${state.data!.description}"',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          Html(
                            data: state.data!.content,
                            style: {
                              'body': Style(
                                fontSize: FontSize(16),
                                lineHeight: const LineHeight(1.5),
                              ),
                            },
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 8),
                          HomeTabSection(
                            title: 'Tag',
                            withPadding: false,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: state.data!.tag.map((e) {
                                return ActionChip(
                                  label: Text(e.name),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TagPage(tag: e.name),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 24),
                          HomeTabSection(
                            title: 'Artikel Terkait',
                            withPadding: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state.data!.related.map((e) {
                                return ArticleListTile(article: e);
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
