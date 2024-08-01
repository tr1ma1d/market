import 'dart:developer';

import 'package:internet_market/core/api/api_service.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductApi extends ApiService {
  final String endUrl = '/api/common/product/list';

  ProductApi(super.baseUrl);

  final Map<String, String> params = {
    'productId': '3972',
    'appKey':
        'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um'
  };

  Future<List<Product>> getProducts(
      {required String selectedCategory,
      required int offset,
      required int limit}) async {
    final Map<String, String> queryParams = {
      ...params,
      'category': selectedCategory,
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    var response = await get(endUrl, queryParams);
    if (response.containsKey('data')) {
      var data = response['data'] as List<dynamic>;
      final productList = madeProductList(selectedCategory, data);

      log('Product $productList');
      return productList;
    } else {
      throw Exception("Failed to load products");
    }
  }

  List<Product> madeProductList(String selectedCategory, List<dynamic> data) {
    if (selectedCategory == 'Ноутбуки') {
      return data
          .where((product) =>
              product['title'].contains('Ноутбук') ||
              product['title'].contains('Ультрабук'))
          .map((item) => Product.fromJson(item))
          .toList();
    }
    if (selectedCategory == 'Телевизоры') {
      return data
          .where((product) => product['title'].contains('LED'))
          .map((item) => Product.fromJson(item))
          .toList();
    }
    if (selectedCategory == 'Смартфоны') {
      return data
          .where((product) => product['title'].contains('Смартфон'))
          .map((item) => Product.fromJson(item))
          .toList();
    }
    return [];
  }

  Future<Product?> getProductById(int id) async {
    // Пример запроса для получения продукта по ID
    var response = await get("/api/common/product/$id", params);
    if (response.containsKey('data')) {
      return Product.fromJson(response['data']);
    } else {
      return null;
    }
  }
}
