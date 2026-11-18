import 'package:ecommerce/core/const/app_color.dart';
import 'package:flutter/material.dart';


class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: _Circle(
            size: 220,
            color: AppColors.pink.withValues(alpha: 0.45),
          ),
        ),
        Positioned(
          top: 120,
          left: -70,
          child: _Circle(
            size: 150,
            color: AppColors.pinkLight.withValues(alpha: 0.9),
          ),
        ),
        Positioned(
          bottom: -90,
          left: -50,
          child: _Circle(
            size: 240,
            color: AppColors.pink.withValues(alpha: 0.35),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;

  const _Circle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
