import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/api/product_api.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/products_controller.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/shopping_cart_page.dart';
import 'package:internet_market/shopModules/views/product_grid_item.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {
  final String categoryTitle;

  const ProductsView({super.key, required this.categoryTitle});
  @override
  // ignore: library_private_types_in_public_api
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductsController controller =
      ProductsController(ProductApi('https://onlinestore.whitetigersoft.ru'));
  Future<List<Product>>? _products;
  ShoppingCartModel shoppingCartModel = ShoppingCartModel();

  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _products = controller.fetchProducts(widget
        .categoryTitle); // Use widget.categoryTitle instead of categoryTitle
    updateCartCount();
  }

  void updateCartCount() {
    setState(() {
      cartCount = shoppingCartModel.items.length;
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
              backgroundColor: Colors.purple,
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
                color: Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
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
      //consumer<ProductsController>(
      body: ProductGridView(products: _products!),
    );
  }
}
