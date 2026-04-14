import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/ui/auth/log_in_screen.dart';

void showLogoutConfirmDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(StringsManager.logoutTitle),
      content: Text(StringsManager.logoutConfirmation),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(StringsManager.cancel),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(dialogContext);
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LogInScreen.routeName,
                (route) => false,
              );
            }
          },
          child: Text(StringsManager.yes),
        ),
      ],
    ),
  );
}
