import 'package:ecommerce/core/const/app_color.dart';
import 'package:flutter/material.dart';


class AuthSwitchRow extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthSwitchRow({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$text ',
          style: const TextStyle(color: AppColors.textGrey, fontSize: 15),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: AppColors.pinkDark,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.pinkDark,
            ),
          ),
        ),
      ],
    );
  }
}
