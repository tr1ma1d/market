import 'dart:developer';

import 'package:internet_market/core/models/base_item_model.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductController extends BaseItemModel<Product> {
  ProductController(this.productApi);

  final ProductApi productApi;

  @override
  Future<void> load(int id) async {
    item = await productApi.getProductById(id);
    onItemLoaded(item); 
  }
  @override
  Product? show() { 
    log(item.toString());
    return item;
  }
}
