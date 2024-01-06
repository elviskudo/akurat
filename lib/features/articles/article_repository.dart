import 'package:cached_query_flutter/cached_query_flutter.dart';

import '../../shared/data/dto/api_result.dart';
import '../../shared/data/src/dio.dart';
import 'models/article.dart';

class ArticleRepository {
  static Query<List<Article>> getHeadline() {
    return Query<List<Article>>(
      key: ['/article/headline/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/article/headline/');
        final res = ApiResult<ArticleResponseData>.fromJson(
          raw.data,
          fromJsonT: ArticleResponseData.fromJson,
        );
        final articles = res.data?.list ?? [];
        return articles;
      },
    );
  }

  static Query<List<Article>> getLatest() {
    return Query<List<Article>>(
      key: ['/article/latest/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/article/latest/');
        final res = ApiResult<ArticleResponseData>.fromJson(
          raw.data,
          fromJsonT: ArticleResponseData.fromJson,
        );
        final articles = res.data?.list ?? [];
        return articles;
      },
    );
  }

  static Query<List<Article>> getEditorsPick() {
    return Query<List<Article>>(
      key: ['/article/editor-pick/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/article/editor-pick/');
        final res = ApiResult<ArticleResponseData>.fromJson(
          raw.data,
          fromJsonT: ArticleResponseData.fromJson,
        );
        final articles = res.data?.list ?? [];
        return articles;
      },
    );
  }

  static Query<List<Article>> getPopular() {
    return Query<List<Article>>(
      key: ['/popular/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/popular/');
        final res = ApiResult<ArticleResponseData>.fromJson(
          raw.data,
          fromJsonT: ArticleResponseData.fromJson,
        );
        final articles = res.data?.list ?? [];
        return articles;
      },
    );
  }
}
