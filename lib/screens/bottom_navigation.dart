import 'package:flutter/material.dart';
import 'package:jkdairies/screens/cart_screen.dart';
import 'package:jkdairies/screens/contact_us.dart';
import 'package:jkdairies/screens/home_screen.dart';
import 'package:jkdairies/utils/constants.dart';

class BottomNavigation extends StatefulWidget {
  static const String id = '/BottomNavigation';
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  // Widget _currentWidget= HomeScreen();
  final _tabScreens = [HomeScreen(), MyCart(), ContactUs()];
  final _tabNames = [
    "Home",
    "My Cart",
    "Contact",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tabNames[_currentIndex],
          style: kAppBarTextStyle,
        ),
      ),
      body: _tabScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 30.0,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: _tabNames[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            activeIcon: Icon(Icons.shopping_cart),
            label: _tabNames[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            activeIcon: Icon(Icons.contact_phone),
            label: _tabNames[2],
          )
        ],
        selectedItemColor: kPrimaryColor,
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
