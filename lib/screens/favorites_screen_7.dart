import 'package:delimeals/models/meal.dart';
import 'package:delimeals/widgets/meal_item_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'you have no favorites yet - start adding some!',
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
            duration: favoriteMeals[index].duration,
        
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
