import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'evently_app.dart';

void main() {
  runApp(
    EasyLocalization(
      startLocale: Locale('ar'),
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: EventlyApp(),
    ),
  );
}
