import 'package:flutter/material.dart';
import 'package:internet_market/mvc/controllers/category_controller.dart';
import 'package:internet_market/mvc/controllers/product_controller.dart';
import 'package:internet_market/mvc/models/category.dart';
import 'package:internet_market/mvc/view/products_view.dart';
import 'package:internet_market/mvc/view/shopping_cart_page.dart';


class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final CategoryController controller = CategoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


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
      body: FutureBuilder<List<Category>>(
        future: controller.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<Category> categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                Category category = categories[index];
                return ListTile(
                  leading: Image.network(
                    category.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(category.name!),
                  onTap: () {
                    // Проверяем, если название категории "laptop"
                    if (category.name!.toLowerCase() == 'laptops') {
                      // Переходим на страницу ProductView
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsView(),
                        ),
                      );
                    } else {
                      // Иначе, вы можете обработать другие категории или ничего не делать
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Category ${category.name} selected')),
                      );
                    }
                  },

                );
              },

            );
          }
        },
      ),
    );
  }
}
