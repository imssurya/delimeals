import 'package:delimeals/dummy_data.dart';
import 'package:delimeals/models/meal.dart';
import 'package:delimeals/screens/category_meals_screen_3.dart';
import 'package:delimeals/screens/category_screen_1.dart';
import 'package:delimeals/screens/filtters_screen_9.dart';
import 'package:delimeals/screens/meal_detail_screen_5.dart';
import 'package:delimeals/screens/tabs_screen_6.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };
  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favoriteMeal=[];

  void _setFilters(Map<String,bool> filterData){
    setState(() {
     _filters=filterData; 
     _availableMeals=DUMMY_MEALS.where((meal){
       if(_filters['gluten'] && !meal.isGlutenFree){
         return false;
       }
       if(_filters['lactose'] && !meal.isLactoseFree){
         return false;
       }
       if(_filters['vegan'] && !meal.isVegan){
         return false;
       }
       if(_filters['vegetarian'] && !meal.isVegetarian){
         return false;
       }  
       return true;
     }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeal.indexWhere((meal) =>meal.id ==mealId);
    if(existingIndex>=0){
      setState(() {
       _favoriteMeal.removeAt(existingIndex); 
      });
    }else{
      _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal)=>meal.id==mealId));
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeal.any((meal)=>meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delimeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      // home: CategoryScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routeName:(ctx) => FilterScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => CategoryScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryScreen(),
        );
      },
    );
  }
}
