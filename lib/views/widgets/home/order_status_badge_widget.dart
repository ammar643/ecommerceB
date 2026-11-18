import 'package:ecommerce/core/const/app_color.dart';
import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.isEmpty ? 'Unknown' : _capitalize(status),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: style.foreground,
        ),
      ),
    );
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  _BadgeStyle _styleFor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return const _BadgeStyle(Color(0xFFE3F3E6), Color(0xFF3D8B4F));
      case 'cancelled':
      case 'canceled':
        return const _BadgeStyle(Color(0xFFFBE3E3), Color(0xFFC25555));
      case 'pending':
      default:
        return const _BadgeStyle(AppColors.pinkLight, AppColors.pinkDark);
    }
  }
}

class _BadgeStyle {
  final Color background;
  final Color foreground;

  const _BadgeStyle(this.background, this.foreground);
}
