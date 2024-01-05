import 'package:cached_query_flutter/cached_query_flutter.dart';

import '../../shared/data/dto/api_result.dart';
import '../../shared/data/src/dio.dart';
import 'models/article.dart';
import 'models/headline.dart';

class ArticleRepository {
  static Query<List<Article>> getHeadlines() {
    return Query<List<Article>>(
      key: ['/article/headline/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/article/headline/');
        final res = ApiResult<HeadlineResponseData>.fromJson(
          raw.data,
          fromJsonT: HeadlineResponseData.fromJson,
        );
        final headlines = res.data?.list ?? [];
        return headlines;
      },
    );
  }
}
