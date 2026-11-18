import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/data/model/get_cart_model.dart';
import 'package:ecommerce/data/model/homepage_mode.dart';
import 'package:flutter/material.dart';


class CartItemTile extends StatelessWidget {
  final ItemsCart item;
  final ProductModel? product;

  const CartItemTile({super.key, required this.item, required this.product});

  @override
  Widget build(BuildContext context) {
    final name = product?.name ?? 'Product #${item.productId}';
    final unitPrice = product?.price;
    final lineTotal = unitPrice == null ? null : unitPrice * item.quantity;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.beigeDark.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // الصورة
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 84,
              height: 84,
              child: _CartImage(url: product?.imageUrl ?? ''),
            ),
          ),
          const SizedBox(width: 14),

          // المعلومات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product != null)
                  Text(
                    product!.category.name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.pinkDark,
                    ),
                  ),
                const SizedBox(height: 2),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  unitPrice == null
                      ? '—'
                      : '\$${unitPrice.toStringAsFixed(2)} each',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  lineTotal == null ? '—' : '\$${lineTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pinkDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // الكمية
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.pinkLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'x${item.quantity}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.pinkDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartImage extends StatelessWidget {
  final String url;

  const _CartImage({required this.url});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: AppColors.beige,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_outlined,
        size: 30,
        color: AppColors.beigeDark,
      ),
    );

    if (url.isEmpty) return placeholder;

    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}
