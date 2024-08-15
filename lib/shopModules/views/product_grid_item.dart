import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/product.dart';
import 'package:internet_market/shopModules/models/products_controller.dart';
import 'package:internet_market/shopModules/product_detail_page.dart';
import 'package:provider/provider.dart';

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
        itemCount: products.length,
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
          Text(
            '${product.price ?? 'Не указана цена'} руб.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              const Icon(Icons.star, size: 14),
              const SizedBox(width: 4),
              Text(
                '${product.rating ?? 0}/5',
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
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
          // Перед переходом на страницу деталей, обновляем данные продукта
          await product.load(product);

          // Переход на страницу деталей продукта
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: product,
                child: const ProductDetailPage(),
              ),
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
    return GridTile(
      header: Container(
        width: double.infinity,
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
