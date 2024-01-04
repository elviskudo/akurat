import 'package:flutter/material.dart';

import '../../features/menu/menu_view.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, this.appBar});

  final Widget child;
  final dynamic appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(),
      resizeToAvoidBottomInset: true,
      drawer: const AppDrawer(),
      body: child,
    );
  }
}
