import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/entities/shoppingcart_model.dart';
import 'package:internet_market/shopModules/product_detail_page.dart';

class ProductGridView extends StatefulWidget
//rename to ProductGridView
{
  final Future<List<Product>> products;
  const ProductGridView({super.key, required this.products});

  @override
  State<StatefulWidget> createState() => ProductGridViewState();
}

class ProductGridViewState extends State<ProductGridView> {
  int cartCount = 0;
  ShoppingCartModel shoppingCartModel = ShoppingCartModel();
  @override
  void initState() {
    super.initState();
    updateCartCount();
  }

  void updateCartCount() {
    setState(() {
      cartCount = shoppingCartModel.items.length;
    });
  }

  Widget buildGridItem(Product product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 300, // Увеличиваем высоту карточки
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (product.imageUrl?.isNotEmpty ?? false)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl!,
                  height: 150.0, // Высота изображения
                  fit: BoxFit.cover,
                ),
              )
            else
              const SizedBox(
                height: 150.0, // Высота placeholder
                width: double.infinity,
                child: Placeholder(),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} руб.',
                        style: const TextStyle(
                          fontSize: 18, // Уменьшаем размер шрифта для цены
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating}/5',
                            style: const TextStyle(
                                fontSize:
                                    14), // Уменьшаем размер шрифта для рейтинга
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.title!,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                        // Уменьшаем размер шрифта для названия
                        ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                          updateCartCount();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.purple),
                          fixedSize:
                              WidgetStateProperty.all(const Size(200, 20)),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: const Text('Подробнее'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductGrid(List<Product> products) {
    //вытащить gridView.builder в ProductGridPage
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.59,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
            updateCartCount();
          },
          child: buildGridItem(product),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: widget.products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Product> products = snapshot.data!;
          return buildProductGrid(products);
        } else {
          return const Center(child: Text('No products found'));
        }
      },
    );
  }
}
