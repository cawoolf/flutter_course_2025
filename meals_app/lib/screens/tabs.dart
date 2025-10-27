import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';
import 'categories_screen.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};


class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    print('STAR CLICKED');

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite');
    }
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Closes the side menu Drawer
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,)));

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false; //Excludes meals that are not GlutenFree
      }

      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false; //Excludes meals that are not LactoseFree
      }

      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false; //Excludes meals that are not Vegetarian
      }

      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false; //Excludes meals that are not Vegan
      }

      return true;
    }).toList();

    Widget activePage =
        CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus, availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          onToggleFavorite: _toggleMealFavoriteStatus,
          title: '',
          meals:
              _favoriteMeals); // Empty title field to avoid double appBar bug
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      // Draws the side bar menu.
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage, // Receives the index of the tab
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
