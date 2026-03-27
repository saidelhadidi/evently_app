import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
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
              Text("User Name", style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          Row(
            crossAxisAlignment: .center,
            children: [
              GestureDetector(
                onTap: () {
                  if (provider.currentTheme == ThemeMode.light) {
                    provider.changeTheme(ThemeMode.dark);
                  } else {
                    provider.changeTheme(ThemeMode.light);
                  }
                },
                child: SvgPicture.asset(
                  provider.currentTheme == ThemeMode.light
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
                  provider.changeLanguage(!provider.isEnglish, context);
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
                    provider.isEnglish ? "EN" : "AR",
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
