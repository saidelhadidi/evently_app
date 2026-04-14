import 'package:evently_app/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/categories_list.dart';
import '../../home/widgets/category_item.dart';

class SelectCategoryList extends StatelessWidget {
  const SelectCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectableCategories = CategoriesList.categories.skip(1).toList();

    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: .symmetric(horizontal: 16),
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              provider.selectEventType(selectableCategories[index].id);
            },
            child: CategoryItem(
              category: selectableCategories[index],
              isSelected:
                  selectableCategories[index].id == provider.selectedCategoryId,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: selectableCategories.length,
      ),
    );
  }
}
