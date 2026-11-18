import 'package:ecommerce/core/const/app_route.dart';
import 'package:ecommerce/data/model/get_order_model.dart';
import 'package:ecommerce/data/model/order_model.dart';
import 'package:ecommerce/data/service/order_services.dart';

import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderServices _orderServices = OrderServices();

  bool isLoading = false;
  String? errorMessage;

  OrderModel? orderData;

  GetOrdersModel? ordersData;
  bool isLoadingOrders = false;
  String? ordersErrorMessage;

  Future<void> addOrder({required int productId, int quantity = 1}) async {
    if (isLoading) return;

    isLoading = true;
    errorMessage = null;
    update();

    try {
      final result = await _orderServices.addorder(
        productId: productId,
        quntity: quantity,
      );

      orderData = result;

      Get.snackbar('Success', 'Order created successfully');
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');

      errorMessage = message;

      Get.snackbar('Error', message);

      if (message == 'Please login again') {
        Get.offAllNamed(AppRoute.login);
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getOrder() async {
    if (isLoadingOrders) return;

    isLoadingOrders = true;
    ordersErrorMessage = null;
    update();

    try {
      ordersData = await _orderServices.getOrder();
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');

      ordersErrorMessage = message;

      Get.snackbar('Error', message);

      if (message == 'Please login again') {
        Get.offAllNamed(AppRoute.login);
      }
    } finally {
      isLoadingOrders = false;
      update();
    }
  }

  List<OrderModel> get orders => ordersData?.orders ?? [];

  Future<void> refreshOrders() async {
    isLoadingOrders = false;
    await getOrder();
  }
}
