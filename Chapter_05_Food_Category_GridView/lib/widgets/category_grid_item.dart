import 'package:flutter/material.dart';
import 'package:sample_app_4/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory, // updated to use function from parent
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16), // match snapshot
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), // LinearGradient
        ), // BoxDecoration
        child: Text(
          category.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ), // TextStyle
        ), // Text
      ), // Container
    ); // InkWell
  }
}
