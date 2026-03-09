import 'package:evently_app/core/resources/size_manager.dart';
import 'package:evently_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  ToggleSwitch({
    super.key,
    required this.choice1,
    required this.choice2,
    required this.isChoice1Selected,
    required this.onChanged,
  });

  final Widget choice1;
  final Widget choice2;
  final bool isChoice1Selected;
  final Function(bool) onChanged;

  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeManager.getScreenHeight(context) * 0.04,
      child: Row(
        mainAxisAlignment: .end,
        spacing: 10,
        children: [
          InkWell(
            borderRadius: .circular(8),
            onTap: () {
              onChanged(true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),

              alignment: .center,
              decoration: BoxDecoration(
                borderRadius: .circular(8),
                color: isChoice1Selected
                    ? AppTheme.lightMode.primaryColor
                    : Colors.white,
              ),
              child: choice1,
            ),
          ),

          InkWell(
            borderRadius: .circular(8),
            onTap: () {
              onChanged(false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: .center,
              decoration: BoxDecoration(
                borderRadius: .circular(8),
                color: isChoice1Selected
                    ? Colors.white
                    : AppTheme.lightMode.primaryColor,
              ),
              child: choice2,
            ),
          ),
        ],
      ),
    );
  }
}
