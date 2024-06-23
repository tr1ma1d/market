import 'package:flutter/material.dart';
import 'package:internet_market/mvc/controllers/products_controller.dart';
import 'package:internet_market/mvc/controllers/product_controller.dart';
import 'package:internet_market/mvc/models/product.dart';
import 'package:internet_market/mvc/view/product_view.dart';
import 'package:internet_market/mvc/view/shopping_cart_page.dart';

class ProductsView extends StatefulWidget {
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductsController controller = ProductsController();
  Future<List<Product>>? _products;
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _products = controller.fetchProducts();
    updateCartCount();
  }

  void updateCartCount() {
    setState(() {
      cartCount = ProductController.getCount() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(),
                  ),
                );
                updateCartCount(); // Update cart count when returning from the shopping cart page
              },
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cartCount.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductView(product: product),
                      ),
                    );
                    updateCartCount();
                  },
                  child: Card(
                    child: Column(
                      children: [
                        if (product.imgUrl != null && product.imgUrl!.isNotEmpty)
                          SizedBox(
                            height: 100.0,
                            width: double.infinity,
                            child: Image.network(
                              product.imgUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          const SizedBox(
                            height: 100.0,
                            width: double.infinity,
                            child: Placeholder(),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.title.toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${product.price} руб.',
                            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}
