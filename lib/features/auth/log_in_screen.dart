import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/custom_text_field.dart';
import 'package:evently_app/features/auth/reset_password_screen.dart';
import 'package:evently_app/features/auth/sign_up_screen.dart';
import 'package:evently_app/features/auth/widgets/google_login_button.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/widgets/header_image.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = "logIn_screen";

  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(title: const HeaderImage(), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    StringsManager.logInPageTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                CustomTextField(
                  hintText: StringsManager.mailHintText,
                  prefixIcon: SvgPicture.asset(AssetsManager.mailIcon),
                ),
                const SizedBox(height: 16),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return CustomTextField(
                      hintText: StringsManager.passwordHintText,
                      prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon),
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.togglePasswordVisibility();
                        },
                        icon: SvgPicture.asset(AssetsManager.eyeIcon),
                      ),
                      isObscure: provider.isPasswordObscured,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ResetPasswordScreen.routeName,
                      );
                    },
                    child: Text(
                      StringsManager.forgetPassword,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomPrimaryButton(
                  title: StringsManager.logIn,
                  onPressed: () {},
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dHaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          SignUpScreen.routeName,
                        );
                      },
                      child: Text(
                        StringsManager.signUp,
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
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                GoogleLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
