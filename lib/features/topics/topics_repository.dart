import 'package:cached_query_flutter/cached_query_flutter.dart';

import '../../shared/data/dto/api_result.dart';
import '../../shared/data/src/dio.dart';
import '../menu/menu_model.dart';

typedef Topic = Menu;

class TopicsRepository {
  static Query<List<Topic>> getTopics() {
    return Query<List<Topic>>(
      key: ['/reference/topics/'],
      queryFn: () async {
        List<Topic> topics = [];

        final raw = await HttpClient.instance.get('/reference/menu/');
        final res = ApiResult<MenuResponseData>.fromJson(
          raw.data,
          fromJsonT: MenuResponseData.fromJson,
        );

        if (res.data != null) {
          for (var element in res.data!.list) {
            topics.add(element);
            if (element.child != null) {
              topics.addAll(element.child!);
              element.child = null;
            }
          }
        }

        topics.sort((a, b) => a.title.compareTo(b.title));

        return topics;
      },
    );
  }
}
