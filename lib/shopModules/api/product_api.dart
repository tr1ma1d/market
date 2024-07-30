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

  Future<List<Product>> getProducts(String selectedCategory) async {
    selectedCategory =
        selectedCategory.substring(0, selectedCategory.length - 1);
    var response = await get(endUrl, params);
    if (response.containsKey('data')) {
      var data = response['data'] as List<dynamic>;
      final productList = madeProductList(selectedCategory, data);

      log('Product $productList');
      return productList;
    } else {
      throw Exception("Product");
    }
  }

  List<Product> madeProductList(String selectedCategory, List<dynamic> data) {
    if (selectedCategory == 'Ноутбук') {
      var productList = data
          .where((product) =>
              product['title'].contains('Ноутбук') || product['title'].contains('Ультрабук'))
          .map((item) => Product.fromJson(item))
          .toList();
      
      return productList;
    }
    if (selectedCategory == 'Телевизор') {
      var productList = data
          .where((product) =>
              product['title'].contains('LED'))
          .map((item) => Product.fromJson(item))
          .toList();
      return productList;
    }
    if(selectedCategory == 'Смартфон'){
      var productList = data
          .where((product) =>
              product['title'].contains('Смартфон'))
          .map((item) => Product.fromJson(item))
          .toList();
      
      return productList;
    }
    return [];
  }

  Future<Product?> getProductById(int id) async {
    // var result = await get("/////", {"productId": id.toString()});
    // парсим JSON в экземпляр продукта
    return null;
  }
}
