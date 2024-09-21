import 'package:flutter/material.dart';
import 'package:bloc_test/movie%20app/constants.dart';
import '../movies/movies_model.dart';

class PageWithMoviesList extends StatefulWidget {
  const PageWithMoviesList({
    required this.title,
    required this.movies,
    super.key,
  });

  final List<Movie> movies;
  final String title;

  @override
  State<PageWithMoviesList> createState() => _PageWithMoviesListState();
}

class _PageWithMoviesListState extends State<PageWithMoviesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: widget.movies.isNotEmpty ? _buildMoviesList() : _buildEmptyState(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget _buildMoviesList() {
    return SingleChildScrollView(
      child: Column(
        children: widget.movies.map((movie) => _buildMovieTile(movie)).toList(),
      ),
    );
  }

  Widget _buildMovieTile(Movie movie) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('$imagePath${movie.backdrop_path}'),
      ),
      title: Text(
        movie.title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('Nothing here', style: TextStyle(color: Colors.white)),
    );
  }
}
