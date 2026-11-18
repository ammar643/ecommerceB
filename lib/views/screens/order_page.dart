import 'package:ecommerce/controller/order_controller.dart';
import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/views/widgets/home/home_loading_widget.dart';
import 'package:ecommerce/views/widgets/home/order_appbar_widget.dart';
import 'package:ecommerce/views/widgets/home/order_empty_widget.dart';
import 'package:ecommerce/views/widgets/home/order_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrderController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<OrderController>()
        ? Get.find<OrderController>()
        : Get.put(OrderController());

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.getOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.beige,
      body: SafeArea(
        child: GetBuilder<OrderController>(
          builder: (c) => Column(
            children: [
              OrdersAppBar(count: c.orders.length, onBack: Get.back),
              Expanded(child: _buildBody(c)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(OrderController c) {
    if (c.isLoadingOrders) return const HomeLoading();

    if (c.ordersErrorMessage != null) {
      return HomeError(message: c.ordersErrorMessage!, onRetry: c.getOrder);
    }

    if (c.orders.isEmpty) return const OrdersEmpty();

    return OrdersList(orders: c.orders, onRefresh: c.refreshOrders);
  }
}
