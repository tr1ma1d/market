import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/product_controller.dart';
import 'package:internet_market/shopModules/models/products_controller.dart';
import 'package:internet_market/shopModules/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductGridItem extends StatelessWidget {
  final List<Product> products;
  final ProductsController controller;

  const ProductGridItem({
    super.key,
    required this.products,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(249, 249, 249, 1),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.60,
        ),
        itemCount: products.length + 2,
        itemBuilder: (context, index) {
          if (index < products.length) {
            final product = products[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProductImage(product),
                  _buildProductDetails(context, product),
                  _buildDetailsButton(context, product),
                ],
              ),
            );
          } else {
            if (!controller.isLoading && controller.hasMoreItems) {
              return _buildLoadingIndicator();
            }
          }
        },
      ),
    );
  }

  Widget _buildProductImage(Product product) {
    return Expanded(
      child: product.imageUrl != null && product.imageUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                product.imageUrl!,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            )
          : Container(
              height: 150.0,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.image_not_supported)),
            ),
    );
  }

  Widget _buildProductDetails(BuildContext context, Product product) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceAndRating(context, product),
            const SizedBox(height: 8),
            _buildProductTitle(context, product),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceAndRating(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(
            '${product.price ?? 'Не указана цена'} руб.',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),),
          Row(children: [
              const Icon(Icons.star, size: 14),
              const SizedBox(width: 4),
              Text(
                '${product.rating ?? 0}/5',
                style: const TextStyle(fontSize: 11),
              ),
            ],)
        ],
      ),
    );
  }

  Widget _buildProductTitle(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        product.title ?? 'Без названия',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.w600),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDetailsButton(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: ElevatedButton(
        onPressed: () async {
          final productController =
              Provider.of<ProductController>(context, listen: false);
          await productController.load(product.productId!);

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const ProductDetailPage(), // Параметры могут потребоваться
            ),
          );
        },
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(const Size(170, 37)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: const Text('Подробнее'),
      ),
    );
  }

  // Индикатор загрузки
  Widget _buildLoadingIndicator() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Skeletonizer(
                ignoreContainers: true,
                child: Container(
                  height: 150.0,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Skeletonizer(
                          child: Container(
                            width: 60.0,
                            height: 14.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Skeletonizer(
                              child: Container(
                                width: 30.0,
                                height: 11.0,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Skeletonizer(
                      child: Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: Skeletonizer(
              child: Container(
                width: 170.0,
                height: 37.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
