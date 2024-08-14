import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_market/shopModules/models/products_controller.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/shopping_cart_page.dart';
import 'package:internet_market/shopModules/views/product_grid_item.dart'; // Обновите импорт

class ProductsView extends StatefulWidget {
  final String categoryTitle;

  const ProductsView({super.key, required this.categoryTitle});

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    super.initState();

    final controller = Provider.of<ProductsController>(context, listen: false);
   
    controller.setSelectedCategory(widget.categoryTitle);
    controller.loadNextItems(0); // Load initial items
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsController>(
      builder: (context, controller, child) {
        return Scaffold(
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
              widget.categoryTitle,
              style: const TextStyle(color: Colors.black),
            ),
            actions: buildActions(),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if (!controller.isLoading && controller.hasMoreItems) {
                  controller.loadNextItems(controller.items.length);
                }
              }
              return true;
            },
            child: ProductGridItem(
              products: controller.items,
              controller: controller,
            ), // Используйте ProductGridItem здесь
          ),
        );
      },
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
