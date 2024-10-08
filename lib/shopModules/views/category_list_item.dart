import 'package:flutter/material.dart';
import 'package:internet_market/shopModules/models/entities/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0), // Use EdgeInsets for padding
            child: Image.network(
              category.imageUrl!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            category.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
