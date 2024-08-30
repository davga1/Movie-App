part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class FetchMovies extends MoviesEvent {
  final String genre;

  FetchMovies(this.genre);
}

class FetchMoviesWithGenreId extends MoviesEvent {
  final int id;

  FetchMoviesWithGenreId(this.id);
}
