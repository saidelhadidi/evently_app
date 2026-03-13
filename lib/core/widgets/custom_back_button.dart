import 'package:evently_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDark ? Colors.transparent : AppColors.lightInputs,
            borderRadius: BorderRadius.circular(8),
            border: isDark
                ? Border.all(color: Theme.of(context).primaryColor, width: 1)
                : null,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
