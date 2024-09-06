import 'dart:developer';
import 'package:internet_market/core/models/base_list_model.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductsController extends BaseListModel<Product> {
  final ProductApi apiService;
  int? _selectedCategory;

  ProductsController(this.apiService);

  @override
  Future<void> loadNextItems(int offset) async {
    if (isLoading || !hasMoreItems) return;
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<Product> products = await apiService.getProducts(
        selectedCategory: _selectedCategory!,
        offset: offset,
        limit: itemsPerPage,
      );
      
      onNextItemsLoaded(products);
    } catch (e) {
      log('Error loading next items: $e');
    } finally {
      
    }
  }

  void setSelectedCategory(int? categoryId) {
    _selectedCategory = categoryId;
    reload();
     // Перезагружаем данные при изменении категории
  }
  

  int? get selectedCategory => _selectedCategory;
}