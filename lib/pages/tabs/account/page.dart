import 'package:flutter/material.dart';

import 'tabs/bookmark/page.dart';
import 'tabs/notifications/page.dart';
import 'widgets/account_app_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [const AccountAppBar()];
          },
          body: const TabBarView(
            children: [
              BookmarkPage(),
              NotificationsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
