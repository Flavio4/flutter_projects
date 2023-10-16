import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(
        children: [
          Image.network(
            meal.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            'Ingredientes',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Pasos',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final step in meal.steps)
                  Text(
                    step,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
