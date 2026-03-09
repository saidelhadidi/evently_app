import 'package:evently_app/core/resources/size_manager.dart';
import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
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

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    Color activeColor = primaryColor;
    final inactiveColor = Theme.of(context).inputDecorationTheme.fillColor ;
    final strokeColor = Theme.of(context).colorScheme.outline;
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
                border: isChoice1Selected
                    ? null
                    : Border.all(color: strokeColor, width: 0.5),
                borderRadius: .circular(8),
                color: isChoice1Selected ? activeColor : inactiveColor,
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
                border: isChoice1Selected
                    ? Border.all(color: strokeColor, width: 0.5)
                    : null,
                borderRadius: BorderRadius.circular(8),
                color: isChoice1Selected ? inactiveColor : activeColor,
              ),
              child: choice2,
            ),
          ),
        ],
      ),
    );
  }
}
