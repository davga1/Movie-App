import 'package:bloc_test/movie%20app/constants.dart';
import 'package:bloc_test/main.dart';
import 'package:bloc_test/movie%20app/movies/movies_bloc.dart';
import 'package:bloc_test/movie%20app/movies/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0]} hr ${parts[1]} min';
}

class MainScreen extends StatefulWidget {
  const MainScreen(
      {required this.movies,
      required this.genres,
      super.key,
      required this.isLoading,
      required this.topRatedMovies,
      required this.trendingMovies});

  final List<Movie> movies;
  final List<dynamic> genres;
  final bool isLoading;
  final List<Movie> topRatedMovies;
  final List<Movie> trendingMovies;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: const Text(
            'Vedix',
            style: TextStyle(color: Colors.blue, fontSize: 25),
          ),
          actions: const [
            Icon(Icons.cast, color: Colors.white),
            SizedBox(width: 25),
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Let's Help You Relax & Watch A Movie!",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) => setState(() {}),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: 'Search',
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            widget.genres.length,
                            (index) => Column(
                              children: [
                                TextButton(
                                  child: Text(
                                    widget.genres[index]['name'],
                                    style: TextStyle(
                                      color:
                                          genreId == widget.genres[index]['id']
                                              ? Colors.blue
                                              : Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    print(
                                        widget.genres[index]['id'].toString());
                                    setState(() {
                                      genreId = widget.genres[index]['id'];
                                      context
                                          .read<MoviesBloc>()
                                          .add(FetchMoviesWithGenreId(genreId));
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color:
                                          widget.genres[index]['id'] == genreId
                                              ? Colors.blue
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: 35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            widget.movies.length,
                            (index) {
                              final movie = widget.movies[index];
                              return WidgetWithScrollingMovies(
                                  widget: widget, movie: movie);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Top Rated Movies',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              widget.topRatedMovies.length,
                              (index) => WidgetWithScrollingMovies(
                                  widget: widget,
                                  movie: widget.topRatedMovies[index]))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Trending Movies',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              widget.topRatedMovies.length,
                              (index) => WidgetWithScrollingMovies(
                                  widget: widget,
                                  movie: widget.trendingMovies[index]))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class WidgetWithScrollingMovies extends StatelessWidget {
  const WidgetWithScrollingMovies({
    super.key,
    required this.widget,
    required this.movie,
  });

  final MainScreen widget;
  final Movie movie;

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
                height: 150,
                width: 300,
              ),
            )
          : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: movie.backdrop_path.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                                '$imagePath${movie.backdrop_path}'),
                            fit: BoxFit.fill,
                          )
                        : null,
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 150,
                  width: 300,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 295),
                    Text(
                      movie.title,
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
    );
  }
}
