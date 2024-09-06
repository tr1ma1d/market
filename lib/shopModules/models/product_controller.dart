import 'dart:developer';

import 'package:internet_market/core/models/base_item_model.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductController extends BaseItemModel<Product> {
  ProductController(int super.id);

  ProductApi? productApi;

  @override
  Future<void> load(Product product) async {

    item = product;
    updateItem(item);
  }
  @override
  Product? show() { 
    log(item.toString());
    return item;
  }
}
