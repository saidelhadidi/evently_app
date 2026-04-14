import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/providers/home_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsManager.welcomeBack,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              homeProvider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      (homeProvider.currentUser?.userName ?? "User")
                          .split(' ')
                          .take(2)
                          .join(' '),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (settingsProvider.currentTheme == ThemeMode.light) {
                    settingsProvider.changeTheme(ThemeMode.dark);
                  } else {
                    settingsProvider.changeTheme(ThemeMode.light);
                  }
                },
                child: SvgPicture.asset(
                  settingsProvider.currentTheme == ThemeMode.light
                      ? AssetsManager.lightMode
                      : AssetsManager.darkMode,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  settingsProvider.changeLanguage(
                    !settingsProvider.isEnglish,
                    context,
                  );
                },
                child: Container(
                  width: 45,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    settingsProvider.isEnglish ? "EN" : "ع",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
