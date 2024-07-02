import 'package:bloc_test/movie%20app/app%20pages/bottom_nav_bar_screens/liked_movies.dart';
import 'package:bloc_test/movie%20app/app%20pages/bottom_nav_bar_screens/saved_movies.dart';
import 'package:bloc_test/movie%20app/app%20pages/bottom_nav_bar_screens/user_page.dart';
import 'package:flutter/material.dart';
import '../movies/movies_model.dart';
import 'bottom_nav_bar_screens/main_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.movies,
    required this.genres,
    required this.isLoading,
    required this.topRatedMovies,
    required this.trendingMovies,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
  final List<Movie> movies;
  final List<dynamic> genres;
  final bool isLoading;
  final List<Movie> topRatedMovies;
  final List<Movie> trendingMovies;
}

class _BottomNavBarState extends State<BottomNavBar> {
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      MainScreen(
        movies: widget.movies,
        genres: widget.genres,
        isLoading: widget.isLoading,
        topRatedMovies: widget.topRatedMovies,
        trendingMovies: widget.trendingMovies,
      ),
      LikedMovies(),
      SavedMovies(),
      UserPage(),
    ];
  }

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
