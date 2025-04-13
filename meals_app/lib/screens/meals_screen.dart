import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    late Widget content;

    if (meals.isEmpty) {
      content = _emptyContent(context);
    }

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => Text(meals[index].title));
    }

    return Scaffold(appBar: AppBar(title: Text(title)), body: content);
  }

  Center _emptyContent(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Uh oh ... nothing here!',
          style: _appThemeHeadlineLarge(context),
        ),
        const SizedBox(height: 16),
        Text('Try selecting a different category',
            style: _appThemeBodyLarge(context))
      ],
    ));
  }
}

TextStyle _appThemeBodyLarge(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(color: Theme.of(context).colorScheme.onSurface);
}

TextStyle _appThemeHeadlineLarge(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .headlineLarge!
      .copyWith(color: Theme.of(context).colorScheme.onSurface);
}

/*
ListView.build() ensures that only items that are visible are rendered. Improves performance.
 */
