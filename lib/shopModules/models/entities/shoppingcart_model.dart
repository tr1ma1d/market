import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ShoppingCartModel with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addItem(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void buyProducts() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(Product product) {
    return _items.contains(product);
  }

  int get count => _items.length;
}
