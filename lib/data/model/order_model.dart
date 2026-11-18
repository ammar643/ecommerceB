class ItemsOrderModel {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  ItemsOrderModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemsOrderModel.fromJson(Map<String, dynamic> json) {
    return ItemsOrderModel(
      id: _toInt(json['id']),
      orderId: _toInt(json['order_id']),
      productId: _toInt(json['product_id']),
      quantity: _toInt(json['quantity']),
      price: _toDouble(json['price']),
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class OrderModel {
  final int id;
  final int userId;
  final double total;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ItemsOrderModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final List list = json['items'] ?? [];

    return OrderModel(
      id: _toInt(json['id']),
      userId: _toInt(json['user_id']),
      status: json['status']?.toString() ?? '',
      total: _toDouble(json['total']),
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
      items: list
          .map((e) => ItemsOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

int _toInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

double _toDouble(dynamic v) {
  if (v is num) return v.toDouble();
  return double.tryParse(v?.toString() ?? '') ?? 0.0;
}
