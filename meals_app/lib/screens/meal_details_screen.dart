import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: () {onToggleFavorite(meal);}, icon: const Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView( // Ensures that content preserves formatting of child, but is Scrollable
        child: Column(
          children: [
            _showMealPhoto(),
            const SizedBox(height: 14),
            _showTitle('Ingredients', context),
            const SizedBox(height: 14),
            for (final ingredient in meal.ingredients)
              _showInstruction(ingredient, context),
            const SizedBox(height: 24),
            _showTitle('Steps', context),
            for (final step in meal.steps)
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: _showInstruction(step, context)),
          ],
        ),
      ),
    );
  }

  Text _showTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold),
    );
  }

  Text _showInstruction(String instruction, BuildContext context) {
    return Text(instruction,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground));
  }

  Image _showMealPhoto() {
    return Image.network(meal.imageUrl,
        width: double.infinity, height: 300, fit: BoxFit.cover);
  }
}

/*
return Scaffold() as the parent widget for new screens
 */
