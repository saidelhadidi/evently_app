import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/custom_text_field.dart';
import 'package:evently_app/features/auth/reset_password_screen.dart';
import 'package:evently_app/features/auth/sign_up_screen.dart';
import 'package:evently_app/features/auth/widgets/google_login_button.dart';
import 'package:evently_app/features/auth/widgets/social_divider.dart';
import 'package:evently_app/features/layout/main_layout.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/remote/local/shared_prefs_helper.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/widgets/header_image.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = "logIn_screen";

  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _firebaseAuthError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearAuthError() {
    if (_firebaseAuthError != null) {
      setState(() {
        _firebaseAuthError = null;
      });
    }
  }

  Future<void> _handleLogin(AuthProvider authProvider) async {
    _clearAuthError();

    if (_formKey.currentState!.validate()) {
      final error = await authProvider.logIn(
        emailController: _emailController,
        passwordController: _passwordController,
      );

      if (!mounted) return;

      if (error != null) {
        _passwordController.clear();
        if (error == StringsManager.invalidCredentials ||
            error == StringsManager.userNotFound) {
          setState(() {
            _firebaseAuthError = error;
          });
          _formKey.currentState!.validate();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } else {
        // Save login status BEFORE navigating
        await SharedPrefsHelper.saveLoginStatus(true);
        if (mounted) {
          Navigator.pushReplacementNamed(context, MainLayout.routeName);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(title: const HeaderImage(), centerTitle: true),
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
                          StringsManager.logInPageTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: StringsManager.mailHintText,
                        prefixIcon: SvgPicture.asset(AssetsManager.mailIcon),
                        onChanged: (_) => _clearAuthError(),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return StringsManager.emailRequired;
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return StringsManager.invalidEmail;
                          }
                          return _firebaseAuthError;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: StringsManager.passwordHintText,
                        prefixIcon: SvgPicture.asset(
                          AssetsManager.passwordIcon,
                        ),
                        onChanged: (_) => _clearAuthError(),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleLogin(authProvider),
                        suffixIcon: IconButton(
                          onPressed: authProvider.togglePasswordVisibility,
                          icon: SvgPicture.asset(
                            authProvider.isPasswordObscured
                                ? AssetsManager.eyeSlashIcon
                                : AssetsManager.eyeIcon,
                          ),
                        ),
                        isObscure: authProvider.isPasswordObscured,
                        validator: (value) {
                          if (_firebaseAuthError != null) return null;
                          if (value == null || value.isEmpty) {
                            return StringsManager.passwordRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            ResetPasswordScreen.routeName,
                          ),
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
                      authProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomPrimaryButton(
                              title: StringsManager.logIn,
                              onPressed: () => _handleLogin(authProvider),
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
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              SignUpScreen.routeName,
                            ),
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
                      const SocialDivider(),
                      const SizedBox(height: 24),
                      const GoogleLoginButton(),
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
