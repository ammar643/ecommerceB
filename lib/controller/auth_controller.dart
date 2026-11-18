import 'package:ecommerce/core/const/app_route.dart';
import 'package:ecommerce/core/storage/token_storage.dart';
import 'package:ecommerce/data/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  final AuthServices _authservice = AuthServices();

  final TextEditingController email = TextEditingController();
  final TextEditingController passwod = TextEditingController();
  final TextEditingController confirmPasswod = TextEditingController();
  final TextEditingController name = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  bool isLoding = false;
  bool isRegistering = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    isLoding = true;
    update();

    try {
      final result = await _authservice.loginMethod(
        email: email.text.trim(),
        password: passwod.text,
      );

      await TokenStorage.saveTokens(accessToken: result.accessToken);
      Get.snackbar('Success', result.message);
      Get.offAllNamed(AppRoute.home);
    } catch (e) {
      Get.snackbar('Error', _cleanError(e));
    } finally {
      isLoding = false;
      update();
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    isRegistering = true;
    update();

    try {
      final result = await _authservice.registerMethod(
        name: name.text.trim(),
        email: email.text.trim(),
        password: passwod.text,
      );

      Get.snackbar('Success', result.message);

      // Get.toNamed(AppRoute.otp, arguments: {'email': result.user.email});
    } catch (e) {
      Get.snackbar('Error', _cleanError(e));
    } finally {
      isRegistering = false;
      update();
    }
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  void goToSignUp() {
    _clearFields();
    Get.toNamed(AppRoute.register);
  }

  void goToLogin() {
    _clearFields();
    Get.back();
  }

  void _clearFields() {
    name.clear();
    email.clear();
    passwod.clear();
    confirmPasswod.clear();
    obscureConfirmPassword = true;
    obscurePassword = true;
  }

  String _cleanError(Object e) => e.toString().replaceFirst('Exception: ', '');

  @override
  void onClose() {
    email.dispose();
    passwod.dispose();
    name.dispose();
    confirmPasswod.dispose();
    super.onClose();
  }
}
