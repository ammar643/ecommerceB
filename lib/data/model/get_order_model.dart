import 'package:ecommerce/data/model/order_model.dart';


class GetOrdersModel {
  final int currentPage;
  final List<OrderModel> orders;
  final String? firstPageUrl;
  final int? from;
  final int lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int perPage;
  final int? to;
  final int total;

  GetOrdersModel({
    required this.currentPage,
    required this.orders,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    final List list = data['data'] ?? [];

    return GetOrdersModel(
      currentPage: data['current_page'] ?? 1,
      orders: list
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: data['first_page_url'],
      from: data['from'],
      lastPage: data['last_page'] ?? 1,
      lastPageUrl: data['last_page_url'],
      nextPageUrl: data['next_page_url'],
      prevPageUrl: data['prev_page_url'],
      perPage: data['per_page'] ?? 10,
      to: data['to'],
      total: data['total'] ?? 0,
    );
  }
}
