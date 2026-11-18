import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/const/apiconstant.dart';
import 'package:ecommerce/data/model/homepage_mode.dart';
import 'package:http/http.dart' as http;


class HomePageService {
  final Uri homePageUrl = Uri.parse(Apiconstant.baseUrl + Apiconstant.homePage);

  static const Duration _timeout = Duration(seconds: 20);

  Future<HomepageModel> getProducts({int? categoryId, int page = 1}) async {
    final uri = homePageUrl.replace(
      queryParameters: {
        'page': page.toString(),
        if (categoryId != null) 'category_id': categoryId.toString(),
      },
    );

    try {
      final response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(_timeout);

      final decoded = _decode(response);

      if (response.statusCode == 200) {
        return HomepageModel.fromJson(decoded);
      }
      throw Exception(
        decoded['message']?.toString() ?? 'Failed to load products',
      );
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
}
