import 'package:flutter/material.dart';

class BaseItemModel<T> extends ChangeNotifier {
  int? id;  // Сделаем id необязательным
  T? item;

  BaseItemModel([this.id]);  // Сделаем id необязательным в конструкторе

  void updateItem(T? newItem) {
    item = newItem;
    notifyListeners();
  }

  //load переопределяется в дочерних классах
  Future<void> load(int newItem) async{
    notifyListeners();
  }

  // Данный метод может быть переопределен в дочерних классах
  void onItemLoaded(T? item) {
    this.item = item;
    notifyListeners();
  }
}
