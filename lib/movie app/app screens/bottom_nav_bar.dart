import 'package:flutter/material.dart';
import '../../main.dart';

class BottomNavBar extends StatefulWidget {
     BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() {
                index = value;
              }),
          showUnselectedLabels: false,
          backgroundColor: Colors.black87,
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                activeIcon: Icon(Icons.circle,size: 10,),
                icon: Icon(Icons.home_outlined, color: Colors.white)),
            BottomNavigationBarItem(
                label: 'Liked Movies',
                activeIcon: Icon(Icons.circle,size: 10,),
                icon: Icon(Icons.favorite_outline, color: Colors.white)),
            BottomNavigationBarItem(
                label: 'Saved Movies',
                activeIcon: Icon(Icons.circle,size: 10,),
                icon:
                    Icon(Icons.bookmark_border_outlined, color: Colors.white)),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.circle,size: 10,),
                label: 'You', icon: Icon(Icons.person, color: Colors.white))
          ]),
    );
  }
}
