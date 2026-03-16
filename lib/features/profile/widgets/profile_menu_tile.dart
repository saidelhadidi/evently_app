import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final Widget trailingWidget;

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        color: Theme.of(context).inputDecorationTheme.fillColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          trailingWidget,
        ],
      ),
    );
  }
}
