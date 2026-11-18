import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/const/apiconstant.dart';
import 'package:ecommerce/data/model/auth_model.dart';
import 'package:ecommerce/data/model/register_model.dart';
import 'package:http/http.dart' as http;


class AuthServices {
  final Uri _loginUrl = Uri.parse(Apiconstant.baseUrl + Apiconstant.loginUrl);
  final Uri _registerUrl = Uri.parse(
    Apiconstant.baseUrl + Apiconstant.register,
  );

  static const Map<String, String> _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static const Duration _timeout = Duration(seconds: 20);

  Future<AuthModel> loginMethod({
    required String email,
    required String password,
  }) async {
    final response = await _post(_loginUrl, {
      'email': email,
      'password': password,
    });

    final data = _decode(response);
    if (response.statusCode == 200) {
      return AuthModel.fromJson(data);
    }
    throw Exception(_errorMessage(data, 'Sign in failed'));
  }

  Future<RegisterModel> registerMethod({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _post(_registerUrl, {
      'name': name,
      'email': email,
      'password': password,
    });

    final data = _decode(response);
    if (response.statusCode == 201) {
      return RegisterModel.fromJson(data);
    }
    throw Exception(_errorMessage(data, 'Sign up failed'));
  }

  Future<http.Response> _post(Uri url, Map<String, dynamic> body) async {
    try {
      return await http
          .post(url, headers: _headers, body: jsonEncode(body))
          .timeout(_timeout);
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
