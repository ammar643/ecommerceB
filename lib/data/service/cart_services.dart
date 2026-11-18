import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/const/apiconstant.dart';
import 'package:ecommerce/core/storage/token_storage.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/data/model/get_cart_model.dart';
import 'package:http/http.dart' as http;


class CartServices {
  final Uri cartUrl = Uri.parse(Apiconstant.baseUrl + Apiconstant.cart);
  final Uri getCartUrl = Uri.parse(Apiconstant.baseUrl + Apiconstant.getCart);

  static const Duration _timeout = Duration(seconds: 20);

  Future<CartModel> addCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http
          .post(
            cartUrl,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              if (token != null) 'Authorization': 'Bearer $token',
            },
            body: jsonEncode({'product_id': productId, 'quantity': quantity}),
          )
          .timeout(_timeout);

      final decoded = _decode(response);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return CartModel.fromJson(decoded);
      }

      if (response.statusCode == 401) {
        throw Exception('Please login again');
      }

      throw Exception(_errorMessage(decoded, 'Failed to add to cart'));
    } on TimeoutException {
      throw Exception('Connection timed out, please try again');
    } on SocketException {
      throw Exception('No internet connection');
    }
  }

  Future<GetCartModel> getcart() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await http
          .get(
            getCartUrl,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              if (token != null) 'Authorization': 'Bearer $token',
            },
          )
          .timeout(_timeout);
      final decoded = _decode(response);

      if (response.statusCode == 200) {
        return GetCartModel.fromJson(
          (decoded['data'] ?? {}) as Map<String, dynamic>,
        );
      }
      if (response.statusCode == 401) {
        throw Exception('Please login again');
      }
      throw Exception(_errorMessage(decoded, 'Failed to get cart'));
    } on TimeoutException {
      throw Exception('Connection timed out, please try again');
    } on SocketException {
      throw Exception('No internet connection');
    }
  }

  Map<String, dynamic> _decode(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      return decoded is Map<String, dynamic> ? decoded : {};
    } catch (_) {
      return {};
    }
  }

  String _errorMessage(Map<String, dynamic> data, String fallback) {
    final errors = data['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final messages = errors.values
          .expand((e) => e is List ? e : [e])
          .map((e) => e.toString())
          .toList();
      if (messages.isNotEmpty) return messages.join('\n');
    }
    return data['message']?.toString() ?? fallback;
  }
}
