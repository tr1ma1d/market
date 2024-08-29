import 'dart:developer';

import 'package:internet_market/core/models/base_item_model.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductController extends BaseItemModel<Product> {
  ProductController(int id) : super(id);

  ProductApi? productApi;
  Product? product; // Удалено static

  @override
  Future<void> load(int id) async {
    productApi = ProductApi('https://onlinestore.whitetigersoft.ru');
    product = await productApi?.getProductById(id);
    updateItem(product);
  }
  
  Product? show() { // Изменено на возвращение Product?
    log(product.toString());
    return product; // Возвращает null, если product не был загружен
  }
}
