import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

import 'menu_repository.dart';
// import 'widgets/app_drawer_header.dart';
import 'widgets/app_drawer_item.dart';
import 'widgets/app_drawer_loading.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: MenuRepository.getMenuItems(),
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.status == QueryStatus.loading) ...[
              const AppDrawerLoading()
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.data?.length,
                itemBuilder: (context, index) {
                  final menu = state.data?[index];
                  if (menu == null) {
                    return const SizedBox.shrink();
                  }
                  return AppDrawerItem(menu: menu);
                },
              ),
            ]
          ],
        );
      },
    );
  }
}
