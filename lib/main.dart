import 'package:flutter/material.dart';
import '/dummy_data (2).dart';
import '/screens/tabs_screen.dart';
import '/screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/filters_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters ={
    'gluten':false,
    'lactose' :false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setfilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten']==true && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose']==true && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan']==true  && !meal.isVegan){
          return false;
        }
        if(_filters['Vegetarian']==true && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId){
        final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id==mealId);
        if(existingIndex >= 0){
          setState(() {
            _favouriteMeals.removeAt(existingIndex);
          });
        }
        else {
          setState(() {
            _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId),);
          });
        }
  }

  bool _isMealFavourite(String id){
    return _favouriteMeals.any((meal) => meal.id==id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
        body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
        ),
        body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
        ),
        title: TextStyle(
        fontSize: 20,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
        ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/' : (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName :(ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FilterScreen.routeName : (ctx) => FilterScreen(_filters, _setfilters),
      },
      
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}


