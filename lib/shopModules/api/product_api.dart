import 'dart:developer';

import 'package:internet_market/core/api/api_service.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductApi extends ApiService {
  final String endUrl = '/api/common/product/list?';

  ProductApi(super.baseUrl);

  final Map<String, String> params = {
    'categoryId': '',
    'appKey':
        'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um'
  };

  Future<List<Product>> getProducts(
      {required int selectedCategory,
      required int offset,
      required int limit}) async {

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

  Future<Product?> getProductById(int? id) async {
    // Пример запроса для получения продукта по ID
    var response = await get(endUrl, params);
    if(response.containsKey('data')) {
      var data = response['data'] as List<dynamic>;
      // Преобразование JSON-объекта в Product
      for(var item in data){
        var product = Product.fromJson(item);
        if(product.productId == id){
          return product; // Найденный продукт
        }
      }
      return null; // Возвращаем продукт
    }
    return null;
  }
}
