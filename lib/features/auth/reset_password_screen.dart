import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/size_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/custom_text_field.dart';
import 'package:evently_app/features/auth/widgets/password_reset_successfully.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_back_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = "reset_password_screen";

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String? _firebaseError;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _clearError() {
    if (_firebaseError != null) {
      setState(() {
        _firebaseError = null;
      });
    }
  }

  Future<void> _handleResetPassword(AuthProvider authProvider) async {
    _clearError();
    if (_formKey.currentState!.validate()) {
      final error = await authProvider.resetPassword(_emailController.text);

      if (!mounted) return;

      if (error != null) {
        setState(() {
          _firebaseError = error;
        });
        _formKey.currentState!.validate();
      } else {
        setState(() {
          _isSuccess = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
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
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (_isSuccess) {
                return PasswordResetSuccessfully();
              }

              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsManager.resetPassword,
                        height: SizeManager.getScreenHeight(context) * 0.35,
                      ),
                      const SizedBox(height: 40),
                      CustomTextField(
                        controller: _emailController,
                        hintText: StringsManager.mailHintText,
                        prefixIcon: SvgPicture.asset(AssetsManager.mailIcon),
                        onChanged: (_) => _clearError(),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleResetPassword(authProvider),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return StringsManager.emailRequired;
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return StringsManager.invalidEmail;
                          }
                          return _firebaseError;
                        },
                      ),
                      const SizedBox(height: 20),
                      authProvider.isLoading
                          ? const CircularProgressIndicator()
                          : CustomPrimaryButton(
                              title: StringsManager.resetPassword,
                              onPressed: () => _handleResetPassword(authProvider),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
