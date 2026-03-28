import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/assets_manager.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsManager.googleIcon, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              StringsManager.loginWithGoogle,
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
