import 'package:flutter/material.dart';

class BaseItemModel<T> extends ChangeNotifier {
  int id;
  T? item;


  void updateItem(T? newItem) {
    item = newItem;
    notifyListeners();
  }

  BaseItemModel(this.id);

  //load переопределяется в дочерних классах
  
  //onItemLoaded обрабатывает загруженные данные и уведомляет слушателей

}