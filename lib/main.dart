import 'package:flutter/material.dart';

import 'pages/_app.dart';
import 'theme/custom_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akurat',
      theme: CustomTheme.themeData(context),
      home: const Application(),
    );
  }
}
