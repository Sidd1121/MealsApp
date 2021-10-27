import 'package:flutter/material.dart';
import '/widgets/main_drawer.dart';
import '/screens/favourites_screen.dart';
import '/screens/categories_screen.dart';
import '/models/meal.dart';


class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabsScreen(this.favouriteMeals);
  

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  
  int _selectedpageIndex=0;

  @override
  void initState() {
    _pages = [
    {'page': CategoriesScreen() , 'title' : 'Categories',},
    {'page':FavouritesScreen(widget.favouriteMeals) , 'title' : 'Your Favourite',},
  ];
    super.initState();
  }

  void _selectpage(int index){
    setState(() {
      _selectedpageIndex=index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedpageIndex]['title'] as String),
        ),
        drawer: MainDrawer(),
      body: _pages[_selectedpageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedpageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor, 
            icon: Icon(Icons.category),
            title: Text('Categories'), 
            ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor, 
            icon: Icon(Icons.star),
            title: Text('Favourites'), 
            ),
        ],
        ),
    );
  }
}