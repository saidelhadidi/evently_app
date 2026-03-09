import 'package:evently_app/core/resources/size_manager.dart';
import 'package:evently_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeManager.getScreenHeight(context) * 0.047,
      child: FilledButton(
        onPressed: () {
          onPressed();
        },
        style: FilledButton.styleFrom(
          overlayColor: Colors.white.withValues(alpha: 0.1),
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(title, style: TextStyle(fontSize: 20, color:AppColors.lightInputs)),
      ),
    );
  }
}
