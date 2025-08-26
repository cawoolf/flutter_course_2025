import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category, void Function(Meal meal) onToggleFavorite) {
    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(onToggleFavorite: onToggleFavorite,  title: category.title, meals: filteredMeals)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
        padding: EdgeInsets.all(25.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20), // Just sets number of Columns, and item count
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category, onToggleFavorite);
                })
        ],
    );
  }
}


/*
Notes:
Use GridView.builder() for better performance and dynamic grid items
Navigator automatically adds back button on pushed routes/Screens
 */
