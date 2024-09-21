import 'package:flutter/material.dart';
import '../../main.dart'; // Ensure this imports the correct location for your screens list.

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      showUnselectedLabels: false,
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.blue,
      items: _navBarItems(),
    );
  }

  List<BottomNavigationBarItem> _navBarItems() {
    return [
      _buildNavItem(
        label: 'Home',
        icon: Icons.home_outlined,
        activeIcon: Icons.circle,
      ),
      _buildNavItem(
        label: 'Liked Movies',
        icon: Icons.favorite_outline,
        activeIcon: Icons.circle,
      ),
      _buildNavItem(
        label: 'Saved Movies',
        icon: Icons.bookmark_border_outlined,
        activeIcon: Icons.circle,
      ),
      _buildNavItem(
        label: 'You',
        icon: Icons.person,
        activeIcon: Icons.circle,
      ),
    ];
  }

  static BottomNavigationBarItem _buildNavItem({
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon, color: Colors.white),
      activeIcon: Icon(activeIcon, size: 10),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
