import 'package:evently_app/features/profile/widgets/profile_menu_tile.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/strings_manager.dart';

class ChangeLanguageOption extends StatelessWidget {
  const ChangeLanguageOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuTile(
      title: StringsManager.language,
      trailingWidget: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).primaryColor,
        size: 20,
      ),
    );
  }
}
