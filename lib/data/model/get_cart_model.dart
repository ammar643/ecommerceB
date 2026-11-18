import 'package:ecommerce/data/model/homepage_mode.dart';


class ItemsCart {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductModel? product;

  ItemsCart({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    this.product,
  });

  factory ItemsCart.fromJson(Map<String, dynamic> json) {
    final rawProduct = json['product'];

    return ItemsCart(
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
      product: rawProduct is Map<String, dynamic>
          ? ProductModel.fromJson(rawProduct)
          : null,
    );
  }
}

class GetCartModel {
  final int id;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ItemsCart> items;

  GetCartModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) {
    final List list = json['items'] ?? [];

    return GetCartModel(
      id: _toInt(json['id']),
      userId: _toInt(json['user_id']),
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
      items: list
          .map((e) => ItemsCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

int _toInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v?.toString() ?? '') ?? 0;
}
