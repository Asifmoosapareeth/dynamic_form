import 'package:dynamic_form/view/listview_page.dart';
import 'package:dynamic_form/view/second_formscreen.dart';
import 'package:flutter/material.dart';

import 'form_view.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;


  final List<Widget> _screens = [
    DynamicFormPage(),
    SecondFormPage(),
    ListViewPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_center),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_justify),
            label: 'Second',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

