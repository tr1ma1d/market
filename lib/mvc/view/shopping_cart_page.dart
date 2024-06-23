import 'package:flutter/material.dart';
import 'package:internet_market/mvc/controllers/product_controller.dart';
import 'package:internet_market/mvc/controllers/shoppingcart_controller.dart';
import 'package:internet_market/mvc/models/product.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  StateCart createState() => StateCart();
}

class StateCart extends State<ShoppingCartPage> {
  ShoppingCartController controller = ShoppingCartController();

  void clearState() {
    setState(() {
      controller.buyProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: ListView.builder(
        itemCount: ProductController.getCount(),
        itemBuilder: (context, index) {
          Product product = Product.list[index];
          return ListTile(
            title: Text(product.title!),
            subtitle: Text('${product.price} руб.'),
            trailing: Text('Рейтинг: ${product.rating}'),
          );
        },
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
              onPressed: clearState,
              child: const Text(
                'Купить',
                style: TextStyle(
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
