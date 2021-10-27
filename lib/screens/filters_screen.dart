import 'package:flutter/material.dart';
import '/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentfilters;

  FilterScreen(this.currentfilters, this.saveFilters );

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  var _gluttenfree=false;
  var _vegetarian=false;
  var _vegan=false;
  var _lactosefree=false;
  
  @override
  initState () {
    _gluttenfree = widget.currentfilters['gluten'];
    _lactosefree = widget.currentfilters['lactose'];
    _vegetarian = widget.currentfilters['vegetarian'];
    _vegan = widget.currentfilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title, 
    String description, 
    bool currentValue, 
    Function updateValue
    ){
    return SwitchListTile(
              title: Text(title), 
              value: currentValue, 
              subtitle: Text(description),
              onChanged: updateValue,
              );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),onPressed: () {
            final selectedFilters = {
    'gluten':_gluttenfree,
    'lactose' :_lactosefree,
    'vegan': _vegan,
    'vegetarian': _vegetarian,
  };
            widget.saveFilters(selectedFilters);
            },),
        ],
        ),
        drawer: MainDrawer(),
      
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20), 
          child: Text('Adjust Your Meal selection', 
          style: Theme.of(context).textTheme.title,
          ),

          ),
          Expanded(child: ListView(children: <Widget>[
            _buildSwitchListTile(
              'Gluten Free', 
              'Only Gluten free meals are included', 
              _gluttenfree,
            (newValue){
              setState(() {
                  _gluttenfree=newValue;
              },);},),
              _buildSwitchListTile(
              'Lactose Free', 
              'Only Lactose free meals are included', 
              _lactosefree,
            (newValue){
              setState(() {
                  _lactosefree=newValue;
              },);},),
              _buildSwitchListTile(
              'Vegetarian', 
              'Only Vegetarian meals are included', 
              _vegetarian,
            (newValue){
              setState(() {
                  _vegetarian=newValue;
              },);},),
              _buildSwitchListTile(
              'Vegan', 
              'Only Vegan meals are included', 
              _vegan,
            (newValue){
              setState(() {
                  _vegan=newValue;
              },);},),
          ],))
      ],)
        );
  }
}