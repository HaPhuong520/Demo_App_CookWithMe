import 'package:flutter/material.dart';
import 'bmi_calculator_page.dart';
import 'home_page_list_food.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// Abcfgh123@
class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final screens = [
     const HomePageFood(),
    const BMICalculatorPage(),
    const ProfilePage(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: const Color.fromARGB(255, 231, 131, 164),
        selectedFontSize: 16,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.pink),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_sharp),
              label: 'BMI',
              backgroundColor: Colors.pink),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pink)
        ],
      ),
    );
  }
}
