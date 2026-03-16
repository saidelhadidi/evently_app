import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/features/profile/widgets/profile_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider.dart';

class DarkSwitcher extends StatelessWidget {
  const DarkSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuTile(
      title: StringsManager.darkMode,
      trailingWidget: Selector<SettingsProvider, ThemeMode>(
        selector: (context, provider) => provider.currentTheme,
        builder: (context, currentTheme, child) {
          return Switch.adaptive(
              value: currentTheme == ThemeMode.dark,
              onChanged: (value) {
                context.read<SettingsProvider>().changeTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            );
        },
      ),
    );
  }
}
