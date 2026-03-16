import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/features/profile/widgets/change_language_option.dart';
import 'package:evently_app/features/profile/widgets/dark_switcher.dart';
import 'package:evently_app/features/profile/widgets/profile_menu_tile.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: .all(16),
          child: Column(
            spacing: 16,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(AssetsManager.profilePicture),
              ),
              Text(
                "Said Elhadidi",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "saidelhadidi1@gmail.com",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              DarkSwitcher(),
              ChangeLanguageOption(),
              ProfileMenuTile(
                title: StringsManager.logout,
                trailingWidget: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
