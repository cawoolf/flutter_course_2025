import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Image.network(meal.imageUrl,
          width: double.infinity, height: 300, fit: BoxFit.cover),
    );
  }
}

/*
return Scaffold() as the parent widget for new screens
 */
