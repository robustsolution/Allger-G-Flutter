import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'Pages/App/app.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('il', 'IL'),
        Locale('fr', 'FR'),
        Locale('de', 'DE'),
        // Locale('ru', 'RU')
      ],
      path: 'lib/Assets/langs',
      fallbackLocale: const Locale('en', 'US'),
      // startLocale: const Locale('en', 'US'),
      assetLoader: CodegenLoader(),
      child: App(),
    ),
  );
}
