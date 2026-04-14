import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/ui/auth/log_in_screen.dart';
import 'package:evently_app/ui/profile/widgets/change_language_option.dart';
import 'package:evently_app/ui/profile/widgets/dark_switcher.dart';
import 'package:evently_app/ui/profile/widgets/logout_confirm_dialog.dart';
import 'package:evently_app/ui/profile/widgets/profile_menu_tile.dart';
import 'package:evently_app/ui/profile/widgets/profile_picture.dart';
import 'package:evently_app/providers/home_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user?.uid != null) {
        context.read<HomeProvider>().fetchUserData(user!.uid);
      }
    });
  }

  void _showDeleteAccountConfirmation() {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(StringsManager.deleteAccountTitle),
        content: Text(StringsManager.deleteAccountConfirmation),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(StringsManager.cancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await context.read<HomeProvider>().deleteUserAccount();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LogInScreen.routeName,
                    (route) => false,
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
            child: Text(StringsManager.yes),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final userData = homeProvider.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const ProfilePicture(),
              const SizedBox(height: 16),
              homeProvider.isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        Text(
                          userData?.userName ??
                              user?.displayName ??
                              "User Name",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData?.email ?? user?.email ?? "User Email",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
              const SizedBox(height: 16),
              const DarkSwitcher(),
              const SizedBox(height: 16),
              const ChangeLanguageOption(),
              const SizedBox(height: 16),
              ProfileMenuTile(
                onTap: () => showLogoutConfirmDialog(context),
                title: StringsManager.logout,
                trailingWidget: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 16),
              ProfileMenuTile(
                onTap: _showDeleteAccountConfirmation,
                title: StringsManager.deleteAccount,
                trailingWidget: Icon(
                  Icons.delete_forever,
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
