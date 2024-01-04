import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../features/topics/topics_view.dart';
import '../shared/data/src/fss.dart';
import '../shared/widgets/app_shell.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  String? token;

  @override
  void initState() {
    super.initState();
    _setToken();
  }

  void _setToken() async {
    final res = await SecureStorage.read('x-access-token');

    setState(() {
      token = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(
        title: WebsafeSvg.asset(
          'assets/logo.svg',
          height: 32.0,
        ),
        centerTitle: true,
        bottom: const TopicsTabBar(),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(token ??= 'Hello, World!'),
        ),
      ),
    );
  }
}
