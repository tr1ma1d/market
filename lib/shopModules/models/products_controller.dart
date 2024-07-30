import 'dart:developer';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';


class ProductsController {
  //  наследовать от BaseListModel
  
  // загрузку данных производим через переопределение метода  loadNextItems
  final ProductApi apiService;

  ProductsController(this.apiService);

  Future<List<Product>> fetchProducts(String selectedCategory) async {
    try {
      // Выполняем запрос и получаем список продуктов
      List<Product> products = await apiService.getProducts(selectedCategory);
      // Логируем полученный список продуктов
      log('Fetched products: $products');
      return products;
    } catch (e) {
      // Обрабатываем ошибки, если запрос не удался
      log('Failed to fetch products: $e');
      rethrow;
    }
  }
}
