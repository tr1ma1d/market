import 'package:internet_market/mvc/models/product.dart';

class ShoppingCartController {
  List<Product> buyProducts() {
    Product.list.clear();
    return Product.list;
  }
}
