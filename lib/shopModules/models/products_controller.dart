import 'dart:developer';
import 'package:internet_market/core/models/base_list_model.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';

class ProductsController extends BaseListModel<Product> {
  final int itemsPerPage = 10;
  final ProductApi apiService;
  String? _selectedCategory;
  ProductsController(this.apiService);

  @override
  Future<void> loadNextItems(int offset) async {
    if (isLoading || !hasMoreItems) return;

    notifyListeners();

    try {
      List<Product> products = await apiService.getProducts(
        selectedCategory: _selectedCategory ?? '',
        offset: offset,
        limit: itemsPerPage,
      );
      onNextItemsLoaded(products);
    } catch (e) {
      log('Error loading next items: $e');
    } finally {
      notifyListeners();
    }
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    reload();
     // Перезагружаем данные при изменении категории
  }

  String? get selectedCategory => _selectedCategory;
}
