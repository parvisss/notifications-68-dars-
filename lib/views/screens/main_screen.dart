import 'package:flutter/material.dart';
import 'package:frp/views/screens/home.dart';
import 'package:frp/views/screens/motivation.dart';
import 'package:frp/views/screens/pomodoro.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    Home(),
     const Pomodoro(),
     Motivation(),
  ];

  void _onTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KRP"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: "Pomodoro",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: "Motivation",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 16,
        selectedIconTheme: const IconThemeData(size: 40),
        selectedItemColor: Colors.blue,
        onTap: _onTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
    );
  }
}
