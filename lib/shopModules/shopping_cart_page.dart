import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  _StateCart createState() => _StateCart();
}

class _StateCart extends State<ShoppingCartPage> {
  void clearState() {
    final cart = Provider.of<ShoppingCartModel>(context, listen: false);
    cart.buyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Корзина',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<ShoppingCartModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: cart.items.isEmpty
                    ? const Center(child: Text('Корзина пуста'))
                    : buildList(context, cart),
              ),
              buildSummary(context, cart),
              buildCheckoutButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget buildList(BuildContext context, ShoppingCartModel cart) {
    final productQuantityMap = <Product, int>{};
    for (var product in cart.items) {
      productQuantityMap[product] = (productQuantityMap[product] ?? 0) + 1;
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: productQuantityMap.length,
      itemBuilder: (context, index) {
        final product = productQuantityMap.keys.elementAt(index);
        final quantity = productQuantityMap[product]!;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.imageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? 'No Title',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price} руб.',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.purple),
                        ),
                        Container(
                     
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 201, 200, 200),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    size: 16, color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    cart.items.remove(product);
                                  });
                                },
                              ),
                              Text('$quantity',
                                  style: const TextStyle(color: Colors.black)),
                              IconButton(
                                icon: const Icon(Icons.add, size: 16),
                                onPressed: () {
                                  setState(() {
                                    cart.items.add(product);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double calculateTotalPrice(ShoppingCartModel cart) {
    double total = 0;
    for (var item in cart.items) {
      total += item.price!;
    }
    return total;
  }

  Widget buildSummary(BuildContext context, ShoppingCartModel cart) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Итоговая сумма:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${calculateTotalPrice(cart).toStringAsFixed(2)} руб.',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: clearState,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: const Text(
          'Перейти к оформлению',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
