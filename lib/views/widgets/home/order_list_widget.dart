import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/data/model/order_model.dart';
import 'package:ecommerce/views/widgets/home/order_card_widget.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  final Future<void> Function() onRefresh;

  const OrdersList({super.key, required this.orders, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.pinkDark,
      backgroundColor: AppColors.white,
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) => OrderCard(order: orders[i]),
      ),
    );
  }
}
