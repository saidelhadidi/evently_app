import 'package:evently_app/core/resources/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/onboarding_data.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.model});

  final OnBoardingData model;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        SvgPicture.asset(
          model.image,
          height: SizeManager.getScreenHeight(context) * 0.46,
          alignment: .topCenter,
          fit: BoxFit.fitWidth,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onPrimaryContainer,
            BlendMode.srcIn,
          ),
        ),
         SizedBox(height: SizeManager.getScreenHeight(context) * 0.02),
        Text(
          model.title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: .start,
        ),
        Text(model.subTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
