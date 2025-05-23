import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
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
                  _selectCategory(context, category);
                })
        ],
      ),
    );
  }
}

void _selectCategory(BuildContext context, Category category) {
  final filteredMeals = dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals)));
}

/*
Notes:
Use GridView.builder() for better performance and dynamic grid items
Navigator automatically adds back button on pushed routes/Screens
 */
