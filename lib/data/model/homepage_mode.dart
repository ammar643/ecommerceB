class CategoryModel {
  final int id;
  final String name;
  final String description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: _toInt(json['id']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isActive: json['is_active'] ?? false,
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final int reservedQuantity;
  final String image;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imageUrl;
  final CategoryModel category;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.reservedQuantity,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: _toInt(json['id']),
      categoryId: _toInt(json['category_id']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: _toDouble(json['price']),
      quantity: _toInt(json['quantity']),
      reservedQuantity: _toInt(json['reserved_quantity']),
      image: json['image']?.toString() ?? '',
      isActive: json['is_active'] ?? false,
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
      imageUrl: json['image_url']?.toString() ?? '',
      category: CategoryModel.fromJson(json['category'] ?? {}),
    );
  }

  int get availableQuantity => quantity - reservedQuantity;
}

class HomepageModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final String? nextPageUrl;
  final List<ProductModel> products;

  HomepageModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.nextPageUrl,
    required this.products,
  });

  bool get hasNextPage => nextPageUrl != null;

  factory HomepageModel.fromJson(Map<String, dynamic> json) {
    final page = (json['data'] ?? {}) as Map<String, dynamic>;
    final list = (page['data'] ?? []) as List;

    return HomepageModel(
      currentPage: _toInt(page['current_page']),
      lastPage: _toInt(page['last_page']),
      perPage: _toInt(page['per_page']),
      total: _toInt(page['total']),
      nextPageUrl: page['next_page_url']?.toString(),
      products: list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
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
