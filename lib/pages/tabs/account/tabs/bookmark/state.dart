import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../features/articles/article_repository.dart';
import '../../../../../features/articles/models/article.dart';

class BookmarkNotifier extends Notifier<List<Article>> {
  @override
  List<Article> build() {
    return ArticleRepository.getSavedArticles();
  }

  void save(Article article) {
    ArticleRepository.saveArticle(article);
    state = state.where((element) => element.id != article.id).toList();
    state = [article, ...state];
  }

  void remove(Article article) {
    ArticleRepository.removeArticle(article);
    state = state.where((element) => element.id != article.id).toList();
  }

  void refresh() {
    state = ArticleRepository.getSavedArticles();
  }
}

final bookmarkProvider = NotifierProvider<BookmarkNotifier, List<Article>>(
  () => BookmarkNotifier(),
);
