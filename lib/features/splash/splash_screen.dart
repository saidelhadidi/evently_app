import 'package:evently_app/core/remote/local/shared_prefs_helper.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/features/onboarding/start_screen.dart';
import 'package:evently_app/features/layout/main_layout.dart';
import 'package:flutter/material.dart';
import '../auth/log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isAnimate = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2000), () async {
      bool isOnboarded = await SharedPrefsHelper.getOnboardingStatus();
      bool isLoggedIn = await SharedPrefsHelper.getLoginStatus();

      if (!mounted) return;

      if (!isOnboarded) {
        Navigator.pushReplacementNamed(context, StartScreen.routeName);
      } else if (!isLoggedIn) {
        Navigator.pushReplacementNamed(context, LogInScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, MainLayout.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOutQuart,
          scale: _isAnimate ? 1.5 : 1.0,
          child: Image.asset(AssetsManager.splashScreen, width: 250),
        ),
      ),
    );
  }
}
