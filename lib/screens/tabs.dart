import 'package:flutter/material.dart';
import 'package:salon_app/screens/categories.dart';
import 'package:salon_app/screens/main_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  var _pageIndex = 0;
  void selectPage(int index) {
    _pageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const MainScreen();
    if (_pageIndex == 1) {
      activePage = const CategoriesScreen();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: _pageIndex,
          items: const [
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                    color: Color.fromARGB(255, 61, 55, 55), Icons.home_filled)),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                    color: Color.fromARGB(255, 61, 55, 55),
                    Icons.apps_rounded)),
            BottomNavigationBarItem(
                label: "",
                icon: Icon(
                    color: Color.fromARGB(255, 61, 55, 55),
                    Icons.calendar_month)),
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                    color: Color.fromARGB(255, 61, 55, 55),
                    Icons.message_rounded)),
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                    color: Color.fromARGB(255, 61, 55, 55),
                    Icons.account_circle_outlined))
          ]),
    );
  }
}
