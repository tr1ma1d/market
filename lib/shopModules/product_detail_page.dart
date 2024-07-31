import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/shopping_cart_page.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ShoppingCartModel shoppingCartModel = ShoppingCartModel();
  bool isAddedToCart = false;

  void addToCart() {
    setState(() {
      isAddedToCart = true;
    });
    Provider.of<ShoppingCartModel>(context, listen: false)
        .addItem(widget.product);
    log(widget.product.toString());
    log(shoppingCartModel.items[0].toString());
  }

  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartPage(),
              ),
            );
          },
          child: const Icon(Icons.shopping_cart),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ShoppingCartModel>(
          builder: (context, cart, child) {
            return Text(
              cart.items.length.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                  ),
            );
          },
        ),
      ),
    ];
  }

  Widget buildItem(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.network(
                  widget.product.imageUrl!,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 216, 59, 255),
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${widget.product.rating}/5',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.product.title!,
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.product.price} руб.',
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Описание:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              widget.product.productDescription!,
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.product.title ?? 'Product Detail',
          style: const TextStyle(color: Colors.black),
        ),
        actions: buildActions(context),
      ),
      body: buildItem(context),
      bottomNavigationBar: buildFooter().first,
    );
  }

  List<Widget> buildFooter() {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        alignment: Alignment.center,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: addToCart,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.purple),
                fixedSize: WidgetStateProperty.all(const Size(300, 45)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: Text(
                isAddedToCart ? 'Добавлено' : 'Добавить в корзину',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      // Purple color
                    ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
