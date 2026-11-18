import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/const/apiconstant.dart';
import 'package:ecommerce/core/storage/token_storage.dart';
import 'package:ecommerce/data/model/get_order_model.dart';
import 'package:ecommerce/data/model/order_model.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  final Uri orderUrl = Uri.parse(Apiconstant.baseUrl + Apiconstant.order);

  static const Duration _timeout = Duration(seconds: 20);

  Future<OrderModel> addorder({
    required int productId,
    required int quntity,
  }) async {
    try {
      final token = await TokenStorage.getToken();

      final response = await http
          .post(
            orderUrl,
            body: jsonEncode({'product_id': productId, 'quantity': quntity}),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              if (token != null) 'Authorization': 'Bearer $token',
            },
          )
          .timeout(_timeout);

      final decodedResponse = _decode(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OrderModel.fromJson(
          (decodedResponse['data'] ?? {}) as Map<String, dynamic>,
        );
      }

      if (response.statusCode == 401) {
        throw Exception('Please login again');
      }

      throw Exception(_errorMessage(decodedResponse, 'Failed to create order'));
    } on TimeoutException {
      throw Exception('Connection timed out, please try again');
    } on SocketException {
      throw Exception('No internet connection');
    }
  }

  Future<GetOrdersModel> getOrder() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await http
          .get(
            orderUrl,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              if (token != null) 'Authorization': 'Bearer $token',
            },
          )
          .timeout(_timeout);

      final decodedResponse = _decode(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetOrdersModel.fromJson(decodedResponse);
      }

      if (response.statusCode == 401) {
        throw Exception('Please login again');
      }

      throw Exception(_errorMessage(decodedResponse, 'Failed to get order'));
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

      if (messages.isNotEmpty) {
        return messages.join('\n');
      }
    }

    return data['message']?.toString() ?? fallback;
  }
}
