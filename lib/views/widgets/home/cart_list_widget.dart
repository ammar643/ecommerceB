import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/data/model/get_cart_model.dart';
import 'package:ecommerce/data/model/homepage_mode.dart';
import 'package:ecommerce/views/widgets/home/cart_item_title_widget.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  final List<ItemsCart> items;
  final ProductModel? Function(ItemsCart) productOf;
  final Future<void> Function() onRefresh;

  const CartList({
    super.key,
    required this.items,
    required this.productOf,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.pinkDark,
      backgroundColor: AppColors.white,
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, i) {
          final item = items[i];
          return CartItemTile(item: item, product: productOf(item));
        },
      ),
    );
  }
}
