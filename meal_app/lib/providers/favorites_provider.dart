import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

//Sirve para manejar el estado de la lista de favoritos
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    //state es el estado actual de la lista de favoritos, en este caso es una lista de meals
    final mealIsFavorite = state.contains(meal);
    //no se pueden usar state.add() o state.remove() porque no se puede mutar el estado directamente,
    // tiene que pisarse con un nuevo estado
    if (mealIsFavorite) {
      //Remueve el meal de la lista de favoritos
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      //Agrega el meal a la lista de favoritos
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
