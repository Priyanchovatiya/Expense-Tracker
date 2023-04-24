import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:expensetracker/main_screens/add_screen.dart';
import 'package:expensetracker/main_screens/analysis_screen.dart';
import 'package:expensetracker/main_screens/profile_screen.dart';
import 'package:expensetracker/main_screens/user_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  List Pages = [
      UserHomeScreen(),
      AnalysisScreen(),
      AddScreen(),
      ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          margin: const  EdgeInsets.symmetric(horizontal: 5),

          child: CustomNavigationBar(
            isFloating: true,
            borderRadius: const Radius.circular(24.0),
            selectedColor: Colors.white,
            unSelectedColor: Colors.white.withOpacity(0.5),
            backgroundColor:   const Color(0xFF262629),
            strokeColor: Colors.transparent,
            scaleFactor: 0.1,
            iconSize: 25,

            currentIndex: _currentIndex,

            items: [
              CustomNavigationBarItem(icon: Icon(CupertinoIcons.home )),
              CustomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar_alt_fill)),
              CustomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled)),
              CustomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled)),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },

          ),
        ),
      ),
    );
  }
}
