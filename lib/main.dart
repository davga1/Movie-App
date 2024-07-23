import 'package:bloc_test/movie%20app/app%20screens/bottom_nav_bar_screens/saved_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie app/app screens/bottom_nav_bar.dart';
import 'movie app/app screens/bottom_nav_bar_screens/liked_movies.dart';
import 'movie app/app screens/bottom_nav_bar_screens/main_screen.dart';
import 'movie app/app screens/bottom_nav_bar_screens/user_page.dart';
import 'movie app/movies/movies_bloc.dart';
import 'movie app/movies/movies_repository.dart';

int genreId = 28;

MoviesBloc moviesBloc = MoviesBloc(MovieRepository())
  ..add(FetchMoviesWithGenreId(genreId));
void main() => runApp(MaterialApp(
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent),
      color: Colors.black,
      themeMode: ThemeMode.dark,
      home: const MovieApp(),
    ));
List screens = [];

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => moviesBloc,
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const CircularProgressIndicator();
          } else if (state is MoviesLoaded) {
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
            return BottomNavBar();
          }
          return const Text('ADD NORMAL LOADING SCREEN!');
        },
      ),
    );
  }
}
