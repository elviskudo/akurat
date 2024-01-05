import 'package:cached_query_flutter/cached_query_flutter.dart';

import '../../shared/data/dto/api_result.dart';
import '../../shared/data/src/dio.dart';
import '../shared/article/article_model.dart';
import 'headline_model.dart';

class HeadlineRepository {
  static Query<List<Article>> getHeadlines() {
    return Query<List<Article>>(
      key: ['/article/headline/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/article/headline/');
        final res = ApiResult<Headline>.fromJson(
          raw.data,
          fromJsonT: Headline.fromJson,
        );
        final headlines = res.data?.list ?? [];
        return headlines;
      },
    );
  }
}
