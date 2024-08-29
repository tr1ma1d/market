import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/models/product_controller.dart';
import 'package:internet_market/shopModules/shopping_cart_page.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isAddedToCart = false;

  void addToCart(Product product) {
    setState(() {
      isAddedToCart = true;
    });
    final shoppingCart = Provider.of<ShoppingCartModel>(context, listen: false);
    shoppingCart.addItem(product);
    log(product.toString());
    log(shoppingCart.items.isNotEmpty
        ? shoppingCart.items[0].toString()
        : 'Корзина пуста');
  }

  @override
  Widget build(BuildContext context) {
    final productController =
        Provider.of<ProductController>(context, listen: false);
    var product = productController.show();
    if (product == null) {
      return Scaffold(
        body: Center(
          child: Text('Продукт не найден'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(product.title ?? 'Детали продукта'),
        actions: buildActions(context),
      ),
      body: Container(
        color: const Color.fromRGBO(249, 249, 249, 1),
        child: buildItem(context, product),
      ),
      bottomNavigationBar: buildFooter(product),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
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

  Widget buildIndicator(BuildContext context, Product product) {
    int current = 0;
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: product.images!.map((url) {
          int index = product.images!.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: current == index
                  ? const Color.fromRGBO(0, 0, 0, 0.9)
                  : const Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildItem(BuildContext context, Product product) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 250.0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 2.0,
                  initialPage: 2,
                ),
                items: product.images?.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        url,
                        fit: BoxFit.fitWidth,
                      );
                    },
                  );
                }).toList(),
              ),
              buildRatingWidget(context, product),
            ],
          ),
          buildIndicator(context, product),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    product.title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${product.price} руб.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color.fromRGBO(86, 64, 218, 1),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
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
            child: SingleChildScrollView(
              child: Text(
                product.productDescription ?? 'Описание недоступно',
                style: const TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooter(Product product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      alignment: Alignment.center,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => addToCart(product),
            style: ButtonStyle(
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
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatingWidget(BuildContext context, Product product) {
    return Positioned(
      top: 30,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.star,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text(
              product.rating != null ? '${product.rating}/5' : '0/5',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
