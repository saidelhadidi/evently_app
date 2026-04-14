import 'package:flutter/material.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/widgets/custom_primary_button.dart';

class PasswordResetSuccessfully extends StatelessWidget {
  const PasswordResetSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 100,
          ),
          const SizedBox(height: 24),
          Text(
            StringsManager.passwordResetEmailSent,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            StringsManager.checkYourInbox,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 40),
          CustomPrimaryButton(
            title: StringsManager.backToLogin,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

