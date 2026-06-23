import 'package:flutter/material.dart';
import 'package:sample_app_4/models/category.dart';
import 'package:sample_app_4/screens/details_page.dart';
import 'package:sample_app_4/widgets/category_grid_item.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Category.getAllCategories();

    void selectFoodCategory(BuildContext context, Category category) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => DetailsPage(
            category: category,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Food Category',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 8.5 / 10,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in categories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                selectFoodCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
