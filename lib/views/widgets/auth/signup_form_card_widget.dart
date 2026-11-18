import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/views/widgets/auth/auth_button_widget.dart';
import 'package:ecommerce/views/widgets/auth/auth_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SignUpFormCard extends StatelessWidget {
  const SignUpFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (c) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.beigeDark.withValues(alpha: 0.6),
              blurRadius: 30,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Form(
          key: c.registerFormKey,
          child: Column(
            children: [
              // Name
              AuthTextField(
                controller: c.name,
                label: 'Full Name',
                hint: 'Your name',
                icon: Icons.person_outline_rounded,
                keyboardType: TextInputType.name,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  if (v.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Email
              AuthTextField(
                controller: c.email,
                label: 'Email',
                hint: 'example@mail.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(v.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Password
              AuthTextField(
                controller: c.passwod,
                label: 'Password',
                hint: '••••••••',
                icon: Icons.lock_outline_rounded,
                obscure: c.obscurePassword,
                suffix: IconButton(
                  onPressed: c.togglePasswordVisibility,
                  icon: Icon(
                    c.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textGrey,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (v.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Confirm password
              AuthTextField(
                controller: c.confirmPasswod,
                label: 'Confirm Password',
                hint: '••••••••',
                icon: Icons.lock_reset_rounded,
                obscure: c.obscureConfirmPassword,
                suffix: IconButton(
                  onPressed: c.toggleConfirmPasswordVisibility,
                  icon: Icon(
                    c.obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textGrey,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (v != c.passwod.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28),

              AuthButton(
                text: 'Create Account',
                isLoading: c.isRegistering,
                onPressed: c.register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}