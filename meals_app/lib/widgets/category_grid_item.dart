import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: gridItemGradient(category)),
        child: Text(
          category.title,
          style: appThemeTitleLarge(context),
        ),
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
GestureDetector() allows for tappable GridItem
InkWell() creates tappable Widget and creates visual feedback
 */
