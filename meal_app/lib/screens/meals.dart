import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;
  //Navigator to meal detail screen
  void _selectedMeal(BuildContext context, Meal meal) {
    final route =
        MaterialPageRoute(builder: (ctx) => MealDetailScreen(meal: meal));

    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: meals.isNotEmpty
            ? ListView.builder(
                itemCount: meals.length,
                itemBuilder: (ctx, index) {
                  final meal = meals[index];
                  return MealItem(
                    meal: meal,
                    onSelectMeal: () {
                      _selectedMeal(context, meal);
                    },
                  );
                },
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No hay nada aqui',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Intenta con otra categoria',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  )
                ],
              )));
  }
}
