

import '../models/product.dart';

class ProductController{
  int? addProduct(Product product){
    Product.list.add(product);


    return getCount();
  }
  static int? getCount(){
    int? count = Product.list.length;
    return count;
  }


}