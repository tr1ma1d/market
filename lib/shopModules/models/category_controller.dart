import 'dart:developer';
import 'package:internet_market/core/models/base_list_model.dart';
import 'package:internet_market/shopModules/api/category_api.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/category.dart';

class CategoryController extends BaseListModel<Category> {
  final CategoryApi categoryApi;
  final ProductApi productApi;
  String? _selectedCategory;

  CategoryController(this.categoryApi, this.productApi);

  @override
  Future<void> loadNextItems(int offset) async {


    try {
      List<Category> categories = await fetchItems(offset);
      onNextItemsLoaded(categories);
    } catch (e) {
      log('Error loading next items: $e');
    } finally {
     
      notifyListeners();
    }
  }

  @override
  Future<List<Category>> fetchItems(int offset) async {
    try {
      List<Category> categories = await categoryApi.getCategory();
      log('Fetched categories: $categories');
      return categories;
    } catch (e) {
      log('Error fetching categories: $e');
      rethrow;
    }
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  String? get selectedCategory => _selectedCategory;
}
