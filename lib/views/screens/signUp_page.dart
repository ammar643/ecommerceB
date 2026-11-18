import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/views/widgets/auth/auth_background_widget.dart';
import 'package:ecommerce/views/widgets/auth/auth_header_widget.dart';
import 'package:ecommerce/views/widgets/auth/auth_switch_row_widget.dart';
import 'package:ecommerce/views/widgets/auth/signup_form_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.beige,
      body: AuthBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AuthHeader(
                  icon: Icons.person_add_alt_1_rounded,
                  title: 'Create Account',
                  subtitle: 'Sign up to get started',
                ),
                const SizedBox(height: 32),
                const SignUpFormCard(),
                const SizedBox(height: 24),
                AuthSwitchRow(
                  text: 'Already have an account?',
                  actionText: 'Login',
                  onTap: controller.goToLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
