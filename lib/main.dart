import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'evently_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      startLocale: Locale('en'),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: EventlyApp(),
    ),
  );
}
