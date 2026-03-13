import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/size_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/theme/app_colors.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/header_image.dart';
import 'package:evently_app/core/widgets/toggle_switch.dart';
import 'package:evently_app/features/onboarding/onboarding_screen.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "startScreen";

  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderImage()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(
                AssetsManager.startImage,
                alignment: .topCenter,
                height: SizeManager.getScreenHeight(context) * 0.4,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              StringsManager.startScreenTitle,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              StringsManager.startScreenSubTitle,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Consumer<SettingsProvider>(
                      builder: (context, manager, child) {
                        return Column(
                          mainAxisAlignment: .end,
                          spacing: 16,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    StringsManager.language,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                        ),
                                  ),
                                ),
                                ToggleSwitch(
                                  choice1: Text(
                                    StringsManager.english,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color:
                                              (manager.currentTheme ==
                                                      ThemeMode.light &&
                                                  !manager.isEnglish)
                                              ? AppColors.lightMain
                                              : null,
                                        ),
                                  ),
                                  choice2: Text(
                                    StringsManager.arabic,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color:
                                              (manager.currentTheme ==
                                                      ThemeMode.light &&
                                                  manager.isEnglish)
                                              ? AppColors.lightMain
                                              : null,
                                        ),
                                  ),
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
                                    StringsManager.theme,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                        ),
                                  ),
                                ),
                                ToggleSwitch(
                                  choice1: SvgPicture.asset(
                                    AssetsManager.lightMode,
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  choice2: SvgPicture.asset(
                                    AssetsManager.darkMode,
                                    colorFilter: ColorFilter.mode(
                                      manager.currentTheme == ThemeMode.light
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
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
                              title: StringsManager.letsStart,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
