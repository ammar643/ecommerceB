import 'package:ecommerce/controller/home_page_controller.dart';
import 'package:ecommerce/core/const/app_route.dart';
import 'package:ecommerce/data/model/get_cart_model.dart';
import 'package:ecommerce/data/model/homepage_mode.dart';
import 'package:ecommerce/data/service/cart_services.dart';
import 'package:get/get.dart';


class CartController extends GetxController {
  final CartServices _cartServices = CartServices();

  int? loadingProductId;
  String? errorMessage;

  GetCartModel? cartData;
  bool isLoadingCart = false;
  String? cartErrorMessage;

  bool isAdding(int productId) => loadingProductId == productId;

  Future<void> addCart({required int productId, int quantity = 1}) async {
    if (loadingProductId != null) return;
    loadingProductId = productId;
    errorMessage = null;
    update();
    try {
      final result = await _cartServices.addCart(
        productId: productId,
        quantity: quantity,
      );
      Get.snackbar('Success', result.message);
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      errorMessage = message;
      Get.snackbar('Error', message);

      if (message == 'Please login again') {
        Get.offAllNamed(AppRoute.login);
      }
    } finally {
      loadingProductId = null;
      update();
    }
  }

  Future<void> getCart() async {
    isLoadingCart = true;
    cartErrorMessage = null;
    update();
    try {
      cartData = await _cartServices.getcart();
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      cartErrorMessage = message;

      if (message == 'Please login again') {
        Get.offAllNamed(AppRoute.login);
      }
    } finally {
      isLoadingCart = false;
      update();
    }
  }

  List<ItemsCart> get items => cartData?.items ?? [];

  Future<void> refreshCart() => getCart();

  ProductModel? productOf(ItemsCart item) {
    if (item.product != null) return item.product;

    if (Get.isRegistered<HomePageController>()) {
      for (final p in Get.find<HomePageController>().products) {
        if (p.id == item.productId) return p;
      }
    }
    return null;
  }

  double get total {
    double sum = 0;
    for (final item in items) {
      final product = productOf(item);
      if (product != null) sum += product.price * item.quantity;
    }
    return sum;
  }
}
