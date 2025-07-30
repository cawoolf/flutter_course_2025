import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals_screen.dart';

import 'categories_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget activePage = const CategoriesScreen();
    var activePageTitle = 'Categories';

    if(_selectedPageIndex == 1) {
      activePage = MealsScreen(title: '', meals: []); // Empty title field to avoid double appBar bug
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title:Text(activePageTitle)
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage, // Receives the index of the tab
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }


}
