part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> genreMovies;
  final List genres;
  final List<Movie> topRatedMovies;
  final List<Movie> trendingMovies;

  MoviesLoaded(
      {required this.genreMovies,
      required this.genres,
      required this.topRatedMovies,
      required this.trendingMovies});
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
