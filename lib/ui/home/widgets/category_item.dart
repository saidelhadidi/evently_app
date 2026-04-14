import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : (Theme.of(context).inputDecorationTheme.border
                        as OutlineInputBorder)
                    .borderSide
                    .color,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              category.icon,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            category.name,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
