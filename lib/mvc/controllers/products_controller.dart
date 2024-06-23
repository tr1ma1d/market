import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:internet_market/mvc/models/product.dart';

class ProductsController {
  Future<List<Product>> fetchProducts() async {
    const url = 'https://onlinestore.whitetigersoft.ru/api/common/product/list?categoryId=3972&appKey=EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('data')) {
        List<dynamic> data = responseBody['data'];
        List<Product> productList = data.map((item) => Product.fromJson(item)).toList();

        // Logging productList
        log('Products fetched: $productList');

        return productList;
      } else {
        throw Exception('Data key not found in response');
      }
    } else {
      throw Exception('Failed to connect to API');
    }
  }
}
