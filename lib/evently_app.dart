import 'package:evently_app/core/theme/app_theme.dart';
import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/auth/reset_password_screen.dart';
import 'package:evently_app/features/auth/sign_up_screen.dart';
import 'package:evently_app/features/events/add_event.dart';
import 'package:evently_app/features/layout/home_layout.dart';
import 'package:evently_app/features/onboarding/onboarding_screen.dart';
import 'package:evently_app/features/onboarding/start_screen.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/providers/home_provider.dart';
import 'package:evently_app/providers/onboarding_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),

      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: provider.currentTheme,
            routes: {
              StartScreen.routeName: (_) => StartScreen(),
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              LogInScreen.routeName: (_) => LogInScreen(),
              SignUpScreen.routeName: (_) => SignUpScreen(),
              ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
              HomeLayout.routeName: (_) => HomeLayout(),
              AddEvent.routeName:(_)=>AddEvent(),
            },
            initialRoute: StartScreen.routeName,
          );
        },
      ),
    );
  }
}
