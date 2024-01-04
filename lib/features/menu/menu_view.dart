import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

import 'menu_repository.dart';
import 'widgets/app_drawer_header.dart';
import 'widgets/app_drawer_item.dart';
import 'widgets/app_drawer_loading.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: QueryBuilder(
        query: MenuRepository.getMenuItems(),
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const AppDrawerHeader(),
                  ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
