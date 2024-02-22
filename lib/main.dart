import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:cached_storage/cached_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/_app.dart';
import 'shared/data/src/dio.dart';
import 'shared/data/src/hive.dart';
import 'theme/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HttpClient.init();
  await Hive.initFlutter();
  await Hive.openBox<String>(HiveStore.savedArticlesBox);

  CachedQuery.instance.configFlutter(
    storage: await CachedStorage.ensureInitialized(),
    config: QueryConfigFlutter(
      refetchOnResume: false,
      refetchOnConnection: true,
      shouldRethrow: kDebugMode,
    ),
  );

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
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
