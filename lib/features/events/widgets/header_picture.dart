import 'package:evently_app/core/models/category_model.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/size_manager.dart';

class HeaderPicture extends StatelessWidget {
  const HeaderPicture({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final isDark = provider.currentTheme == ThemeMode.dark;
    final imagePath = isDark ? category.darkImage : category.lightImage;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: SizeManager.getScreenHeight(context) * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}