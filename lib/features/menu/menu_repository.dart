import 'package:cached_query_flutter/cached_query_flutter.dart';

import '../../shared/data/dto/api_result.dart';
import '../../shared/data/src/dio.dart';
import 'menu_model.dart';

class MenuRepository {
  static Query<List<Menu>> getMenus() {
    return Query<List<Menu>>(
      key: ['/reference/menu/'],
      queryFn: () async {
        final raw = await HttpClient.instance.get('/reference/menu/');
        final res = ApiResult<MenuResponseData>.fromJson(
          raw.data,
          fromJsonT: MenuResponseData.fromJson,
        );
        final menus = res.data?.list ?? [];
        return menus;
      },
    );
  }
}
