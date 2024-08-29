import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/api/category_api.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/category_controller.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/core/themes/theme.dart';
import 'package:internet_market/shopModules/models/product_controller.dart';
import 'package:internet_market/shopModules/models/products_controller.dart';
import 'package:provider/provider.dart';
import 'package:internet_market/shopModules/category_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingCartModel()),
        ChangeNotifierProvider(
          create: (_) => CategoryController(
            CategoryApi('https://onlinestore.whitetigersoft.ru'),
            ProductApi('https://onlinestore.whitetigersoft.ru'),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => ProductsController(
                  ProductApi('https://onlinestore.whitetigersoft.ru'),
                )),
        ChangeNotifierProvider(
          create: (_) => ProductController(0),
        )
      ],
      child: MaterialApp(
        theme: appTheme,
        home: const CategoryPage(),
      ),
    );
  }
}
