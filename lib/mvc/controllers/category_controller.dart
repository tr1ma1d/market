import 'dart:developer';

import 'package:internet_market/mvc/models/category.dart';

class CategoryController {
  Future<List<Category>> getCategories() async {

    await Future.delayed(const Duration(seconds: 2)); // Имитируем задержку
    List<Category> categoryList = [
      Category(id: 1, name: "Laptops", imageUrl: "https://cdn-icons-png.freepik.com/256/59/59505.png?semt=ais_hybrid"),
      Category(id: 2, name: "Phone", imageUrl: "https://cdn-icons-png.flaticon.com/512/0/191.png"),

    ];
    log(categoryList.toString());
    return categoryList;
  }
}
