import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    //Filtramos las comidas por categoría
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    //Sirve para navegar a otra pantalla, en este caso a MealsScreen
    final route = MaterialPageRoute(
      builder: (ctx) =>
          MealsScreen(title: category.title, meals: filteredMeals),
    );

    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elige el tipo de comida'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate:
            //Crea una grid de 2 columnas
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
