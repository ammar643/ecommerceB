import 'package:ecommerce/controller/cart_controller.dart';
import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/views/widgets/home/cart_appbar_widget.dart';
import 'package:ecommerce/views/widgets/home/cart_empity_widget.dart';
import 'package:ecommerce/views/widgets/home/cart_list_widget.dart';
import 'package:ecommerce/views/widgets/home/cart_summary_widget.dart';
import 'package:ecommerce/views/widgets/home/home_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.getCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.beige,
      body: SafeArea(
        child: GetBuilder<CartController>(
          builder: (c) => Column(
            children: [
              CartAppBar(itemsCount: c.items.length, onBack: Get.back),
              Expanded(child: _buildBody(c)),
              if (!c.isLoadingCart && c.items.isNotEmpty)
                CartSummary(
                  itemsCount: c.items.length,
                  total: c.total,
                  onCheckout: () {
                    Get.snackbar('Soon', 'Checkout is coming soon');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CartController c) {
    if (c.isLoadingCart) return const HomeLoading();

    if (c.cartErrorMessage != null) {
      return HomeError(message: c.cartErrorMessage!, onRetry: c.getCart);
    }

    if (c.items.isEmpty) return const CartEmpty();

    return CartList(
      items: c.items,
      productOf: c.productOf,
      onRefresh: c.refreshCart,
    );
  }
}
