import 'package:flutter/material.dart';
import 'package:internet_market/mvc/controllers/product_controller.dart';
import 'package:internet_market/mvc/models/product.dart';
import 'package:internet_market/mvc/view/shopping_cart_page.dart';

class ProductView extends StatefulWidget {
  final Product product;
  ProductView({required this.product});

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductController controller = ProductController();
  bool isAddedToCart = false;

  void addToCart() {
    setState(() {
      isAddedToCart = true;
    });
    controller.addProduct(widget.product);
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
        title: Text(widget.product.title!),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(),
                  ),
                );
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
              ProductController.getCount().toString(),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.product.imgUrl != null && widget.product.imgUrl!.isNotEmpty)
              Image.network(
                widget.product.imgUrl!,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20.0),
            Text(
              widget.product.title!,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              '${widget.product.price} руб.',
              style: const TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: addToCart,
              child: Text(
                isAddedToCart ? 'Добавлено' : 'В корзину',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
