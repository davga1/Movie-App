import 'package:bloc/bloc.dart';
import 'package:bloc_test/movie%20app/movies/movies_repository.dart';
import 'package:meta/meta.dart';

import 'movies_model.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc(this.repository) : super(MoviesInitial()) {
    on<FetchMoviesWithGenreId>(_fetchMoviesWithGenreId);
  }

  final MovieRepository repository;

  _fetchMoviesWithGenreId(
      FetchMoviesWithGenreId event, Emitter<MoviesState> emit) async {
    try {
      final movies = await repository.fetchGenreMovies(event.id);
      final genres = await repository.getGenres();
      final topRatedMovies = await repository.fetchMovies('top_rated');
      final trendingMovies = await repository.getTrendingMovies();
      emit(MoviesLoaded(
          genreMovies: movies,
          genres: genres,
          topRatedMovies: topRatedMovies,
          trendingMovies: trendingMovies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
