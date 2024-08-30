import 'package:bloc_test/movie%20app/app%20screens/bottom_nav_bar_screens/saved_movies.dart';
import 'package:bloc_test/movie%20app/app%20screens/loading_screen.dart';
import 'package:bloc_test/movie%20app/app%20screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie app/app screens/bottom_nav_bar.dart';
import 'movie app/app screens/bottom_nav_bar_screens/liked_movies.dart';
import 'movie app/app screens/bottom_nav_bar_screens/main_screen.dart';
import 'movie app/app screens/bottom_nav_bar_screens/user_page.dart';
import 'movie app/movies/movies_bloc.dart';
import 'movie app/movies/movies_repository.dart';

late SharedPreferences prefs;
int genreId = 28;
MoviesBloc moviesBloc = MoviesBloc(MovieRepository())
  ..add(FetchMoviesWithGenreId(genreId));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    theme: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      canvasColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    color: Colors.black,
    home: prefs.getBool('logged_in') == null ||
            prefs.getBool('logged_in') == false
        ? const LoginPage()
        : const MovieApp(),
  ));
}

List screens = [];

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => moviesBloc,
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          Widget currentScreen;
          if (state is MoviesLoaded) {
            screens = [
              MainScreen(
                movies: state.genreMovies,
                genres: state.genres,
                isLoading: false,
                topRatedMovies: state.topRatedMovies,
                trendingMovies: state.trendingMovies,
              ),
              const LikedMovies(),
              const SavedMovies(),
              const UserPage(),
            ];
            currentScreen = BottomNavBar();
          } else {
            currentScreen = const LoadingScreen();
          }

          return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: currentScreen,
          );
        },
      ),
    );
  }
}
