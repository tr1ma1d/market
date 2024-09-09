import 'package:flutter/material.dart';

class BaseItemModel<T> extends ChangeNotifier {
  T? item;

  void updateItem(T? newItem) {
    item = newItem;
    notifyListeners();
  }

  //load переопределяется в дочерних классах
  Future<void> load(int id) async{
    
  }
  T? show(){
    return item;
  }
  // Данный метод может быть переопределен в дочерних классах
  void onItemLoaded(T? item) {
    this.item = item;
    notifyListeners();
  }
}
