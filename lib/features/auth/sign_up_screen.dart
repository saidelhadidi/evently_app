import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/auth/widgets/google_signup_button.dart';
import 'package:evently_app/features/auth/widgets/social_divider.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/widgets/custom_primary_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/header_image.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "signUp_screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? _firebaseEmailError;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearAuthError() {
    if (_firebaseEmailError != null) {
      setState(() {
        _firebaseEmailError = null;
      });
    }
  }

  Future<void> _handleSignUp(AuthProvider authProvider) async {
    _clearAuthError();

    if (_formKey.currentState!.validate()) {
      String? error = await authProvider.signUp(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
      );

      if (!mounted) return;

      if (error != null) {
        if (error == StringsManager.emailInUse) {
          setState(() {
            _firebaseEmailError = error;
          });
          _formKey.currentState!.validate();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          LogInScreen.routeName,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(title: const HeaderImage()),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          StringsManager.signUpPageTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: StringsManager.userHintText,
                        prefixIcon: SvgPicture.asset(AssetsManager.userIcon),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return StringsManager.nameRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: emailController,
                        hintText: StringsManager.mailHintText,
                        prefixIcon: SvgPicture.asset(AssetsManager.mailIcon),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _clearAuthError(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return StringsManager.emailRequired;
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return StringsManager.invalidEmail;
                          }
                          return _firebaseEmailError;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: passwordController,
                        hintText: StringsManager.passwordHintText,
                        prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon),
                        textInputAction: TextInputAction.next,
                        suffixIcon: ExcludeFocus(
                          child: IconButton(
                            onPressed: authProvider.togglePasswordVisibility,
                            icon: SvgPicture.asset(
                              authProvider.isPasswordObscured
                                  ? AssetsManager.eyeSlashIcon
                                  : AssetsManager.eyeIcon,
                            ),
                          ),
                        ),
                        isObscure: authProvider.isPasswordObscured,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.passwordRequired;
                          }
                          if (value.length < 8) {
                            return StringsManager.passwordTooShort;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: StringsManager.confirmPasswordHint,
                        prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleSignUp(authProvider),
                        suffixIcon: ExcludeFocus(
                          child: IconButton(
                            onPressed: authProvider.toggleConfirmPasswordVisibility,
                            icon: SvgPicture.asset(
                              authProvider.isConfirmPasswordObscured
                                  ? AssetsManager.eyeSlashIcon
                                  : AssetsManager.eyeIcon,
                            ),
                          ),
                        ),
                        isObscure: authProvider.isConfirmPasswordObscured,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return StringsManager.passwordsDontMatch;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      authProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomPrimaryButton(
                              title: StringsManager.signUp,
                              onPressed: () => _handleSignUp(authProvider),
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
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              LogInScreen.routeName,
                            ),
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
                      const SocialDivider(),
                      const SizedBox(height: 24),
                      const GoogleSignupButton(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
