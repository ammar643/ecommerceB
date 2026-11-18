import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/views/widgets/auth/auth_button_widget.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  final int itemsCount;
  final double total;
  final VoidCallback onCheckout;

  const CartSummary({
    super.key,
    required this.itemsCount,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppColors.beigeDark.withValues(alpha: 0.6),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _row('Items', '$itemsCount'),
          const SizedBox(height: 10),
          _row('Total', '\$${total.toStringAsFixed(2)}', highlight: true),
          const SizedBox(height: 18),
          AuthButton(text: 'Checkout', onPressed: onCheckout),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool highlight = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: highlight ? 17 : 15,
              fontWeight: highlight ? FontWeight.w800 : FontWeight.w500,
              color: highlight ? AppColors.textDark : AppColors.textGrey,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: highlight ? 22 : 15,
            fontWeight: FontWeight.w800,
            color: highlight ? AppColors.pinkDark : AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
