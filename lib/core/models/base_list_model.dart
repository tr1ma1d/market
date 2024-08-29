import 'dart:developer';
import 'package:flutter/material.dart';

class BaseListModel<T> extends ChangeNotifier {
  final List<T> _items = [];
  bool _isLoading = false;
  bool _hasMoreItems = true;

  List<T> get items => _items;
  bool get isLoading => _isLoading;
  bool get hasMoreItems => _hasMoreItems;

  void addItem(T item) {
    _items.add(item);
    notifyListeners();
  }

  //нужны флаги загрузки, текущее состояние и окончание загрузки
  void removeItem(T item) {
    _items.remove(item);
    notifyListeners();
  }

  void reload() {
    _items.clear();
    _isLoading = false;
    _hasMoreItems = true;
    
    loadNextItems(0);
  }

  //loadNextItems - принимает в себя количество ранее загруженных элементов offset,
  // переопределяется в наследниках
  Future<void> loadNextItems(int offset) async {
    if (_isLoading || !_hasMoreItems) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<T> newItems = await fetchItems(offset);
      onNextItemsLoaded(newItems);
    } catch (e) {
      log('Error loading next items');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //onNextItemsLoaded метод вызывается при загрузке новых элементов, реализуется внутри базовой модели
  //вызывается из loadNextItems, и добавляет новые элементы в _items,
  //контролирует флаги загрузки, текущее состояние
  //по окончании обработки должен уведометь слушателей об изменении вызвав метод notifyListeners
  void onNextItemsLoaded(List<T> newItems) {
    if (newItems.isEmpty) {
      _hasMoreItems = false;
    } else {
      _items.addAll(newItems);
    }
    notifyListeners();
  }

  Future<List<T>> fetchItems(int offset) async {
    return [];
  }

  //reload очистит список и вызывает loadNextItems с нулевым офсетом, при этом должны быть сброшены флаги загрузки, текущее состояние
  //add локально добавляет новый элемент в список, не вызывает loadNextItems
  //remove локально удаляет элемент из списка, не вызывает loadNextItems
}
