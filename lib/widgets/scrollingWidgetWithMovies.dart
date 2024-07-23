import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../movie app/app screens/bottom_nav_bar_screens/main_screen.dart';
import '../movie app/app screens/movie_details.dart';
import '../movie app/constants.dart';
import '../movie app/movies/movies_model.dart';
import '../movie app/movies/movies_repository.dart';

class ScrollingWidgetWithMovies extends StatelessWidget {
  const ScrollingWidgetWithMovies({super.key,
    required this.widget,
    required this.movie,
    required this.height,
    required this.width,
    required this.image,
    required this.titleLength});

  final MainScreen widget;
  final Movie movie;
  final double height;
  final double width;
  final String image;
  final int titleLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: widget.isLoading
            ? Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            height: height,
            width: width,
          ),
        )
            : Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    MovieRepository().getMovie(movie.id).then((movie) =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MovieDetails(
                                movie: movie,
                              ),
                        )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: movie.backdrop_path.isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage('$imagePath$image'),
                        fit: BoxFit.fill,
                      )
                          : null,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: height,
                    width: width,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateName(movie.title, titleLength),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '⭐${movie.vote_average.toStringAsFixed(1)}/10',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '  ${genreMap[movie.genre_ids[0]] ?? 'Unknown'}  ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}