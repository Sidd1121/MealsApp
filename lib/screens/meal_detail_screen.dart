import 'package:flutter/material.dart';
import '/models/meal.dart';
import '../dummy_data (2).dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = '/meal_detail';
  final Function toggleFavourite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavourite, this.isFavorite);
  Widget buildsectionTitle(BuildContext context,  String text){
    return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text, 
              style: Theme.of(context).textTheme.title,
              ),
              );
  }
  Widget buildContainer(Widget child){
    return Container(
                decoration: BoxDecoration(
                  color: Colors.white, 
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                height: 150,
                width: 300,
                child:child ,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id==mealId); 
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}'),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300, 
            width: double.infinity, 
            child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover,),
            
            ),
            buildsectionTitle(context, 'Ingredients'),
                buildContainer( ListView.builder(
                    itemBuilder: (ctx, index) => Card(
                      color: Theme.of(context).accentColor, 
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10
                          ),
                        child: Text(selectedMeal.ingredients[index],
                        ),
                      ),
                      ),
                      itemCount: selectedMeal.ingredients.length,
                        ),
                ),
                buildsectionTitle(context, 'Steps'),
                buildContainer(ListView.builder(
                  itemBuilder: (ctx, index)=> Column(children: [ListTile(
                    leading: CircleAvatar(child: Text('# ${index + 1}'),),
                    title: Text(selectedMeal.steps[index],),
                  ),
                  Divider(),
                  ],),
                  itemCount: selectedMeal.steps.length,
                ),),
        ],
      
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed:() => toggleFavourite(mealId),
        ),
    );
  }
}