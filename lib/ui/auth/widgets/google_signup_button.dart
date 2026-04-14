import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/providers/home_provider.dart';
import 'package:evently_app/ui/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/assets_manager.dart';

class GoogleSignupButton extends StatelessWidget {
  const GoogleSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: homeProvider.isLoading
            ? null
            : () async {
                await homeProvider.signInWithGoogle();
                if (context.mounted && homeProvider.currentUser != null) {
                  Navigator.pushReplacementNamed(context, MainLayout.routeName);
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        child: homeProvider.isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetsManager.googleIcon,
                      width: 24, height: 24),
                  const SizedBox(width: 12),
                  Text(
                    StringsManager.signupWithGoogle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
