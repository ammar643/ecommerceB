import 'package:ecommerce/core/const/app_route.dart';
import 'package:ecommerce/views/screens/cart_page.dart';
import 'package:ecommerce/views/screens/home_page.dart';
import 'package:ecommerce/views/screens/order_page.dart';
import 'package:ecommerce/views/screens/signUp_page.dart';
import 'package:flutter/material.dart';



Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.home: (context) => HomeScreen(),
  AppRoute.register: (context) => SignUpScreen(),



  AppRoute.cart: (context) => CartScreen(),
  AppRoute.orders: (context) => OrdersScreen(),
};
