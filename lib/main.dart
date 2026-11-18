import 'package:ecommerce/core/const/app_route.dart';
import 'package:ecommerce/views/screens/home_page.dart';
import 'package:ecommerce/views/screens/login_page.dart';
import 'package:ecommerce/views/screens/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.login,
      getPages: [
        GetPage(name: AppRoute.login, page: () => LoginScreen()),
        GetPage(name: AppRoute.register, page: () => SignUpScreen()),
        GetPage(name: AppRoute.home, page: () => HomeScreen()),
      ],
    );
  }
}
