import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: meals.isNotEmpty
            ? ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  //Lista de Comidas por Categoria
                  return ListTile(
                    title: Text(meal.title),
                  );
                },
              )
            : const Center(
                child: Text('No se encontraron comida de este tipo'),
              ));
  }
}
