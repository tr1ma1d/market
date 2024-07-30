import 'dart:developer';
import 'package:internet_market/api/api_service.dart';
import 'package:internet_market/shopModules/models/entities/category.dart';

class CategoryApi extends ApiService {
  final String endUrl = '/api/common/category/list';

  CategoryApi(super.baseUrl);

  final Map<String, String> params = {
    'categoryId': '3972',
    'appKey': 'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um'
  };

  Future<List<Category>> getCategory() async {
  try {
    var response = await get(endUrl, params);
    if (response.containsKey('data')) {
      var data = response['data'] as Map<String, dynamic>;
      if (data.containsKey('categories')) {
        var categories = data['categories'] as List<dynamic>;
        final categoryList = categories.map((item) => Category.fromJson(item)).toList();
        log('Category: $categoryList');
        return categoryList;
      } else {
        throw Exception('Categories key not found in data');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  } catch (e) {
    log('Error fetching categories: $e');
    rethrow;
  }
}
}
