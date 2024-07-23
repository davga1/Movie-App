import 'package:bloc_test/movie%20app/constants.dart';
import 'package:bloc_test/movie%20app/movies/movies_repository.dart';
import 'package:flutter/material.dart';

import '../movies/movies_model.dart';

class PageWithMoviesList extends StatefulWidget {
  const PageWithMoviesList({required this.title,required this.movies, super.key});

  final List<Movie> movies;
  final String title;

  @override
  State<PageWithMoviesList> createState() => _PageWithMoviesListState();
}

class _PageWithMoviesListState extends State<PageWithMoviesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.movies.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...List.generate(
                      widget.movies.length,
                      (index) => ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '$imagePath${widget.movies[index].backdrop_path}')),
                            title: Text(
                              widget.movies[index].title,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                ],
              ),
            ),
          )
        : const Scaffold(
            body: Center(
              child: Text('Nothing here'),
            ),
          );
  }
}
