import 'package:bloc_test/movie%20app/app%20pages/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: MovieApp(),
    ));

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => moviesBloc,
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          try {
            if (state is MoviesLoading) {
              return CircularProgressIndicator();
            } else if (state is MoviesLoaded) {
              return BottomNavBar(
                  movies: state.genreMovies,
                  genres: state.genres,
                  isLoading: false,
                  topRatedMovies: state.topRatedMovies,
                  trendingMovies: state.trendingMovies);
            }
          } catch (e) {
            print(e.toString());
          }
          return Text('something went wrong');
        },
      ),
    );
  }
}
