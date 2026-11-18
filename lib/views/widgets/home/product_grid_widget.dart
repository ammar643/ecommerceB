import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/data/model/homepage_mode.dart';
import 'package:ecommerce/views/widgets/home/product_card_widget.dart';
import 'package:flutter/material.dart';


class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final Future<void> Function() onRefresh;

  const ProductGrid({
    super.key,
    required this.products,
    required this.scrollController,
    required this.isLoadingMore,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.pinkDark,
      backgroundColor: AppColors.white,
      onRefresh: onRefresh,
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => ProductCard(product: products[i]),
                childCount: products.length,
              ),
            ),
          ),
          if (isLoadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.pinkDark,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
