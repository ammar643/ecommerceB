class CartItemModel {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: _toInt(json['id']),
      cartId: _toInt(json['cart_id']),
      productId: _toInt(json['product_id']),
      quantity: _toInt(json['quantity']),
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class CartModel {
  final String message;
  final CartItemModel item;

  CartModel({required this.message, required this.item});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      message: json['message']?.toString() ?? '',
      item: CartItemModel.fromJson(json['data'] ?? {}),
    );
  }
}

int _toInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? 0;
}
