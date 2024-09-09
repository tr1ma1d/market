import 'dart:developer';

import 'package:internet_market/core/api/api_service.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductApi extends ApiService {
  
  int? categoryId = 0;
  ProductApi(super.baseUrl);

  Future<List<Product>> getProducts(
      {required int selectedCategory,
      required int offset,
      required int limit}) async {
    final Map<String, String> params = {
      'categoryId': '',
      'appKey':
          'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um'
    };
    String endUrl = '/api/common/product/list?';
    categoryId = selectedCategory;
    params['categoryId'] = selectedCategory.toString();
    log(params.toString());
    final Map<String, String> queryParams = {
      ...params,
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    var response = await get(endUrl, queryParams);
    if (response.containsKey('data')) {
      var data = response['data'] as List<dynamic>;

      // Преобразование данных в список объектов Product
      List<Product> products =
          data.map((productJson) => Product.fromJson(productJson)).toList();

      return products; // Возвращаем список продуктов
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<Product> getProductById(int productId) async {
  final Map<String, String> params = {
    'productId': productId.toString(),
    'appKey':
        'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um'
  };
  const String detailsUrl = '/api/common/product/details?'; // Используйте корректный URL

  var response = await get(detailsUrl, params);
  if (response.containsKey('data')) {
    var data = response['data']; // Получаем данные как объект, а не список
    return Product.fromJson(data); // Преобразуем в объект Product
  } else {
    throw Exception("Failed to load product");
  }
}
}
