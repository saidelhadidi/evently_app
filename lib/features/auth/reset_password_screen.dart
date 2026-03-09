import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/size_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/widgets/custom_back_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "reset_password_screen";

  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 66,
        leading: const CustomBackButton(),
        title: Text(
          StringsManager.resetPasswordScreenTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              AssetsManager.resetPassword,
              height: SizeManager.getScreenHeight(context) * 0.45,
            ),
            const SizedBox(height: 40),
            CustomPrimaryButton(
              title: StringsManager.resetPassword,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
