import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/views/widgets/auth/auth_background_widget.dart';
import 'package:ecommerce/views/widgets/auth/auth_header_widget.dart';
import 'package:ecommerce/views/widgets/auth/auth_switch_row_widget.dart';
import 'package:ecommerce/views/widgets/auth/login_form_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

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
                  icon: Icons.lock_outline_rounded,
                  title: 'Welcome Back',
                  subtitle: 'Sign in to continue',
                ),
                const SizedBox(height: 32),
                const LoginFormCard(),
                const SizedBox(height: 24),
                AuthSwitchRow(
                  text: "Don't have an account?",
                  actionText: 'Sign up',
                  onTap: controller.goToSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
