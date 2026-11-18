import 'package:ecommerce/data/model/homepage_mode.dart';
import 'package:ecommerce/data/service/home_page_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePageController extends GetxController {
  final HomePageService _homePageService = HomePageService();

  final ScrollController scrollController = ScrollController();
  final Map<int, String> categories = {};
  final List<ProductModel> products = [];

  int? selectedCategoryId;

  bool isLoading = false;
  bool isLoadingMore = false;
  String? errorMessage;

  int _currentPage = 1;
  bool hasNextPage = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    update();

    try {
      final result = await _homePageService.getProducts(
        categoryId: selectedCategoryId,
        page: 1,
      );

      products
        ..clear()
        ..addAll(result.products);

      _collectCategories(result.products);

      _currentPage = result.currentPage;
      hasNextPage = result.hasNextPage;
    } catch (e) {
      errorMessage = _cleanError(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || isLoading || !hasNextPage) return;

    isLoadingMore = true;
    update();

    try {
      final result = await _homePageService.getProducts(
        categoryId: selectedCategoryId,
        page: _currentPage + 1,
      );

      products.addAll(result.products);
      _currentPage = result.currentPage;
      hasNextPage = result.hasNextPage;
    } catch (e) {
      Get.snackbar('Error', _cleanError(e));
    } finally {
      isLoadingMore = false;
      update();
    }
  }

  Future<void> selectCategory(int? categoryId) async {
    if (selectedCategoryId == categoryId) return;

    selectedCategoryId = categoryId;

    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }

    await fetchProducts();
  }

  Future<void> refreshProducts() => fetchProducts();

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final position = scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  String _cleanError(Object e) => e.toString().replaceFirst('Exception: ', '');

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _collectCategories(List<ProductModel> list) {
    for (final p in list) {
      categories[p.category.id] = p.category.name;
    }
  }
}
