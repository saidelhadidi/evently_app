import 'package:evently_app/features/profile/widgets/profile_menu_tile.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/strings_manager.dart';

class ChangeLanguageOption extends StatelessWidget {
  const ChangeLanguageOption({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    return ProfileMenuTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      StringsManager.english,
                      style: TextStyle(
                        fontWeight: provider.isEnglish
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: provider.isEnglish
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    trailing: provider.isEnglish
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                    onTap: () {
                      provider.changeLanguage(true, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      StringsManager.arabic,
                      style: TextStyle(
                        fontWeight: !provider.isEnglish
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: !provider.isEnglish
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    trailing: !provider.isEnglish
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                    onTap: () {
                      provider.changeLanguage(false, context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      title: StringsManager.language,
      trailingWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            provider.isEnglish ? StringsManager.english : StringsManager.arabic,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
