import 'package:flutter/material.dart';

import '../shared/data/src/fss.dart';

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
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(token ??= 'Hello, World!'),
        ),
      ),
    );
  }
}
