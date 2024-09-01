import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(Theme.of(context).textTheme),
      
      body: Consumer<ShoppingCartModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: cart.items.isEmpty
                    ? _buildEmptyCartMessage()
                    : _buildProductList(context, cart),
              ),
              _buildSummary(context, cart),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(TextTheme textTheme) {
  return AppBar(
    automaticallyImplyLeading: false, 
    backgroundColor: Colors.white,
    title: Text(
      'Корзина',
      style: textTheme.titleLarge,
    ),
  );
}


  Widget _buildEmptyCartMessage() {
    return const Center(child: Text('Корзина пуста'));
  }

  Widget _buildProductList(BuildContext context, ShoppingCartModel cart) {
    final productQuantityMap = _getProductQuantityMap(cart);

    return Container(
      color: const Color.fromRGBO(249, 249, 249, 1),
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: productQuantityMap.length,
        itemBuilder: (context, index) {
          final product = productQuantityMap.keys.elementAt(index);
          final quantity = productQuantityMap[product]!;
          return _buildProductItem(context, cart, product, quantity);
        },
      ),
    );
  }

  Map<Product, int> _getProductQuantityMap(ShoppingCartModel cart) {
    final productQuantityMap = <Product, int>{};
    for (var product in cart.items) {
      productQuantityMap[product] = (productQuantityMap[product] ?? 0) + 1;
    }
    return productQuantityMap;
  }

  Widget _buildProductItem(BuildContext context, ShoppingCartModel cart,
      Product product, int quantity) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 150,
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
          _buildProductImage(product),
          const SizedBox(width: 16),
          _buildProductDetails(context, cart, product, quantity),
        ],
      ),
    );
  }

  Widget _buildProductImage(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              const Icon(
                Icons.star,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text(
                product.rating != null ? '${product.rating}/5' : '0/5',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            product.imageUrl!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails(BuildContext context, ShoppingCartModel cart,
      Product product, int quantity) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProductTitleAndRemoveButton(context, cart, product),
          _buildProductPriceAndQuantity(context, cart, product, quantity),
        ],
      ),
    );
  }

  Widget _buildProductTitleAndRemoveButton(
      BuildContext context, ShoppingCartModel cart, Product product) {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.title!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 16,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              cart.items.removeWhere((item) => item == product);
            });
          },
        ),
      ],
    );
  }

  Widget _buildProductPriceAndQuantity(BuildContext context,
      ShoppingCartModel cart, Product product, int quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${product.price} руб.',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        _buildQuantityControls(context, cart, product, quantity),
      ],
    );
  }

  Widget _buildQuantityControls(BuildContext context, ShoppingCartModel cart,
      Product product, int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 201, 200, 200),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete, size: 16, color: Colors.black),
            onPressed: () {
              setState(() {
                cart.items.remove(product);
              });
            },
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: const TextStyle(color: Colors.black),
            ),
          ),
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
    );
  }

  double _calculateTotalPrice(ShoppingCartModel cart) {
    double total = 0;
    for (var item in cart.items) {
      total += item.price!;
    }
    return total;
  }

  Widget _buildSummary(BuildContext context, ShoppingCartModel cart) {
    double totalPrice = _calculateTotalPrice(cart);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Итоговая сумма: ${totalPrice.toStringAsFixed(2)} руб.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 300,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            final cart = Provider.of<ShoppingCartModel>(context, listen: false);
            cart.buyProducts();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: const Text(
            'Перейти к оформлению',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
