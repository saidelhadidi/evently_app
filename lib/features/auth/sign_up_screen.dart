import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/auth/widgets/google_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resources/assets_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_primary_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/header_image.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "signUp_screen";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const HeaderImage()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  StringsManager.signUpPageTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              CustomTextField(
                hintText: StringsManager.userHintText,
                prefixIcon: SvgPicture.asset(AssetsManager.userIcon),
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: StringsManager.mailHintText,
                prefixIcon: SvgPicture.asset(AssetsManager.mailIcon),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: StringsManager.passwordHintText,
                prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AssetsManager.eyeIcon),
                ),
                isObscure: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: StringsManager.confirmPasswordHint,
                prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AssetsManager.eyeIcon),
                ),
                isObscure: true,
              ),
              const SizedBox(height: 50),
              CustomPrimaryButton(
                title: StringsManager.signUp,
                onPressed: () {},
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringsManager.haveAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LogInScreen.routeName,
                      );
                    },
                    child: Text(
                      StringsManager.logIn,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(
                    child: Divider(thickness: 2, color: AppColors.lightStroke),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(thickness: 2, color: AppColors.lightStroke),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GoogleSignupButton(),
            ],
          ),
        ),
      ),
    );
  }
}
