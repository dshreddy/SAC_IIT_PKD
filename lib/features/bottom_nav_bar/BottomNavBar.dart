import 'package:flutter/material.dart';
import '../../features/profile/Profile.dart';
import '../../features/calender/Calender.dart';
import '../../features/home/Home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static String id = "bottom_nav_screen";

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CalenderScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("SAC"),
          // actions: [
          //   Tooltip(
          //     message: 'Notifications',
          //     child: IconButton(
          //       icon: const Icon(Icons.notifications),
          //       selectedIcon: const Icon(Icons.brightness_2_outlined),
          //       onPressed: () {  },
          //     ),
          //   )
          // ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calender',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}