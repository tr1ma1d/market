import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/views/category_list_item.dart';
import 'package:provider/provider.dart';
import 'package:internet_market/shopModules/models/category_controller.dart';
import 'package:internet_market/shopModules/models/entities/category.dart';
import 'package:internet_market/shopModules/shopping_cart_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<CategoryController>(context, listen: false);
      controller.loadNextItems(3);
    });
  }

  List<Widget> buildActions() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart,
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Consumer<ShoppingCartModel>(
                builder: (context, cart, child) {
                  return CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.items.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget buildGrid(BuildContext context, List<Category> categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        Category category = categories[index];
        return CategoryItem(category: category);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Каталог', style: TextStyle(color: Colors.black)),
        actions: buildActions(),
        elevation: 1,
      ),
      body: Consumer<CategoryController>(builder: (context, controller, child) {
        if (controller.isLoading) {
          log('Loading categories...');
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.items.isEmpty) {
          log('No data available');
          return const Center(child: Text('No data available'));
        }

        log('Displaying categories: ${controller.items}');
        return buildGrid(context, controller.items);
      }),
    );
  }
}
