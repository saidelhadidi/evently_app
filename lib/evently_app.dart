import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/theme/app_theme.dart';
import 'package:evently_app/ui/auth/log_in_screen.dart';
import 'package:evently_app/ui/auth/reset_password_screen.dart';
import 'package:evently_app/ui/auth/sign_up_screen.dart';
import 'package:evently_app/ui/events/add_event.dart';
import 'package:evently_app/ui/events/edit_event.dart';
import 'package:evently_app/ui/events/event_details.dart';
import 'package:evently_app/ui/home/home_tab.dart';
import 'package:evently_app/ui/layout/main_layout.dart';
import 'package:evently_app/ui/onboarding/onboarding_screen.dart';
import 'package:evently_app/ui/onboarding/start_screen.dart';
import 'package:evently_app/ui/splash/splash_screen.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:evently_app/providers/home_provider.dart';
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
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: provider.currentTheme,
            routes: {
              SplashScreen.routeName: (_) => SplashScreen(),
              StartScreen.routeName: (_) => StartScreen(),
              OnboardingScreen.routeName: (_) => OnboardingScreen(),
              LogInScreen.routeName: (_) => LogInScreen(),
              SignUpScreen.routeName: (_) => SignUpScreen(),
              ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
              MainLayout.routeName: (_) => MainLayout(),
              AddEvent.routeName: (_) => AddEvent(),
              EventDetails.routeName: (_) => EventDetails(),
              EditEvent.routeName: (_) => EditEvent(),
              HomeTab.routeName:(_)=>HomeTab(),
            },
            initialRoute: SplashScreen.routeName,
          );
        },
      ),
    );
  }
}
