import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/size_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/header_image.dart';
import 'package:evently_app/core/widgets/toggle_switch.dart';
import 'package:evently_app/features/onboarding/onboarding_screen.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "startScreen";

  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderImage()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Image.asset(
              AssetsManager.startImage,
              height: SizeManager.getScreenHeight(context) * 0.5,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            Text(
              "Personalize Your Experience",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Consumer<SettingsProvider>(
                  builder: (context, manager, child) {
                    return Column(
                      mainAxisAlignment: .end,
                      spacing: 16,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Language",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            ToggleSwitch(
                              choice1: Text('English'),
                              choice2: Text('Arabic'),
                              isChoice1Selected: manager.isEnglish,
                              onChanged: (bool p1) {
                                manager.changeLanguage(p1);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Theme",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            ToggleSwitch(
                              choice1: Icon(Icons.light_mode),
                              choice2: Icon(Icons.dark_mode),
                              isChoice1Selected:
                                  manager.currentTheme == ThemeMode.light,
                              onChanged: (bool isLightSelected) {
                                manager.changeTheme(
                                  isLightSelected
                                      ? ThemeMode.light
                                      : ThemeMode.dark,
                                );
                              },
                            ),
                          ],
                        ),
                        CustomPrimaryButton(
                          title: "Let's start",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              OnboardingScreen.routeName,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
