import 'package:flutter/material.dart';

import 'tabs/bookmark/page.dart';
// import 'tabs/notifications/page.dart';
import 'widgets/account_app_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        // length: 2,
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [AccountAppBar(pageController: pageController)];
          },
          body: const TabBarView(
            children: [
              BookmarkPage(),
              // NotificationsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
