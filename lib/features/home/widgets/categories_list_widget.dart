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
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: .symmetric(horizontal: 16),
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              provider.changeCategoryView(CategoriesList.categories[index].id);
            },
            child: CategoryItem(
              category: CategoriesList.categories[index],
              isSelected:
                  CategoriesList.categories[index].id ==
                  provider.currentCategoryId,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: CategoriesList.categories.length,
      ),
    );
  }
}
