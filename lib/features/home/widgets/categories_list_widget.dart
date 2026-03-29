import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/constants/categories_list.dart';
import 'package:evently_app/features/home/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/home_provider.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    // Explicitly accessing context.locale here forces the widget to rebuild
    // as soon as easy_localization changes the language.
    context.locale;

    final categories = CategoriesList.categories;

    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              provider.changeCategoryView(categories[index].id);
            },
            child: CategoryItem(
              category: categories[index],
              isSelected: categories[index].id == provider.currentCategoryId,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}
