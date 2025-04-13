import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: gridItemGradient(category)),
      child: Text(
        category.title,
        style: appThemeTitleLarge(context),
      ),
    ); //
  }
}

TextStyle appThemeTitleLarge(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(color: Theme.of(context).colorScheme.onSurface);
}

LinearGradient gridItemGradient(Category category) {
  return LinearGradient(colors: [
    category.color.withValues(alpha: 0.55),
    category.color.withValues(alpha: 0.9)
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}

/*
Notes:
Container() useful for setting background elements
 */
