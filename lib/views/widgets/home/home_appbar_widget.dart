import 'package:ecommerce/core/const/app_color.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onCartTap;
  final VoidCallback? onOrdersTap;

  const HomeAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onCartTap,
    this.onOrdersTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          _RoundIconButton(
            icon: Icons.receipt_long_outlined,
            onTap: onOrdersTap,
          ),
          const SizedBox(width: 10),
          _RoundIconButton(icon: Icons.shopping_bag_outlined, onTap: onCartTap),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.pink.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.pinkDark),
      ),
    );
  }
}
