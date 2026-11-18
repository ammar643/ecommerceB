import 'package:ecommerce/controller/home_page_controller.dart';
import 'package:ecommerce/core/const/app_color.dart';
import 'package:ecommerce/core/const/app_route.dart';
import 'package:ecommerce/views/widgets/home/gategory_chips_widget.dart';
import 'package:ecommerce/views/widgets/home/home_appbar_widget.dart';
import 'package:ecommerce/views/widgets/home/home_loading_widget.dart';
import 'package:ecommerce/views/widgets/home/product_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());

    return Scaffold(
      backgroundColor: AppColors.beige,
      body: SafeArea(
        child: GetBuilder<HomePageController>(
          builder: (c) => Column(
            children: [
               HomeAppBar(
                onCartTap: ()=> Get.toNamed(AppRoute.cart),
                onOrdersTap: ()=> Get.toNamed(AppRoute.orders),
                title: 'Discover',
                subtitle: 'Find your perfect style',
              ),
              const SizedBox(height: 8),
              CategoryChips(
                categories: c.categories,
                selectedId: c.selectedCategoryId,
                onSelected: c.selectCategory,
              ),
              Expanded(child: _buildBody(c)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(HomePageController c) {
    if (c.isLoading) return const HomeLoading();

    if (c.errorMessage != null) {
      return HomeError(message: c.errorMessage!, onRetry: c.fetchProducts);
    }

    if (c.products.isEmpty) return const HomeEmpty();

    return ProductGrid(
      products: c.products,
      scrollController: c.scrollController,
      isLoadingMore: c.isLoadingMore,
      onRefresh: c.refreshProducts,
    );
  }
}
