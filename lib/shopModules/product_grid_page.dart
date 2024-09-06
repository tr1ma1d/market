import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/category.dart';
import 'package:provider/provider.dart';
import 'package:internet_market/shopModules/models/products_controller.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/shopping_cart_page.dart';
import 'package:internet_market/shopModules/views/product_grid_item.dart'; // Обновите импорт

class ProductsView extends StatefulWidget {
  final Category category;
  const ProductsView({super.key, required this.category});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late ProductsController controller;

  @override
  void initState() {
    super.initState();
    controller = ProductsController(ProductApi("https://onlinestore.whitetigersoft.ru"));
    controller.setSelectedCategory(widget.category.categoryId);
    controller.loadNextItems(0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.category.title.toString(),
            style: const TextStyle(color: Colors.black),
          ),
          actions: buildActions(),
        ),
        body: Consumer<ProductsController>(
          builder: (context, controller, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  if (!controller.isLoading && controller.hasMoreItems) {
                    controller.loadNextItems(controller.items.length );
                  }
                }
                return true;
              },
              child: ProductGridItem(
                products: controller.items,
                controller: controller,
              ),
            );
          },
        ),
      ),
    );
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
}
