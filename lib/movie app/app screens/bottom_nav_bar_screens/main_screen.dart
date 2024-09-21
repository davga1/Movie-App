import 'package:bloc_test/movie%20app/app%20screens/sign_in.dart';
import 'package:bloc_test/movie%20app/app%20screens/movie_details.dart';
import 'package:bloc_test/movie%20app/app%20screens/page_with_movies_list.dart';
import 'package:bloc_test/movie%20app/constants.dart';
import 'package:bloc_test/main.dart';
import 'package:bloc_test/movie%20app/movies/movies_bloc.dart';
import 'package:bloc_test/movie%20app/movies/movies_model.dart';
import 'package:bloc_test/movie%20app/movies/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/scrollingWidgetWithMovies.dart';

Widget searchedMovies = const SizedBox();

class MainScreen extends StatefulWidget {
  const MainScreen({
    required this.movies,
    required this.genres,
    super.key,
    required this.isLoading,
    required this.topRatedMovies,
    required this.trendingMovies,
  });

  final List<Movie> movies;
  final List<dynamic> genres;
  final bool isLoading;
  final List<Movie> topRatedMovies;
  final List<Movie> trendingMovies;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List genres = [];
Map<int, String> genreMap = {};

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    _fetchGenres();
    Future.delayed(
      Duration(seconds: 5),
      () => print(prefs.getBool('logged_in')),
    );
    super.initState();
  }

  late SharedPreferences prefs;

  _fetchGenres() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('a', true);
    var fetchedGenres = await MovieRepository().getGenres();
    setState(() {
      genres = fetchedGenres;
      genreMap = {for (var genre in genres) genre['id']: genre['name']};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Movie House',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
        actions: const [
          Icon(Icons.cast, color: Colors.white),
          SizedBox(width: 25),
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20),
        children: [
          const Text(
            "Let's Help You Relax & Watch A Movie!",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        searchedMovies = const SizedBox();
                      });
                    } else {
                      MovieRepository()
                          .searchMovies(value, 1)
                          .then((searchResults) {
                        if (searchResults.isNotEmpty) {
                          setState(() {
                            searchedMovies = Column(
                              children: [
                                ...List.generate(
                                  2,
                                  (index) {
                                    final movie =
                                        searchResults['results'][index];
                                    final imageUrl = movie['backdrop_path'] !=
                                            null
                                        ? '$imagePath${movie['backdrop_path']}'
                                        : null;

                                    return GestureDetector(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white12,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 85,
                                                  height: 85,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: imageUrl != null
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      imageUrl),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.grey,
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      movie['title'],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      '${movie['release_date'].toString().substring(0, 4)} • ${genreMap[movie['genre_ids'][0]] ?? 'Unknown'}',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white54),
                                                    ),
                                                    Text(
                                                      '⭐${movie['vote_average'].toStringAsFixed(1)}/10',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () => MovieRepository()
                                          .getMovie(movie['id'])
                                          .then(
                                            (movie) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetails(
                                                          movie: movie,
                                                        ))),
                                          ),
                                    );
                                  },
                                )
                              ],
                            );
                          });
                        }
                      });
                    }
                  },
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
                searchedMovies,
              ],
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
                            color: genreId == widget.genres[index]['id']
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                        onPressed: () {
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
                            color: widget.genres[index]['id'] == genreId
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
                    return ScrollingWidgetWithMovies(
                      image: movie.backdrop_path,
                      height: 150,
                      width: 300,
                      widget: widget,
                      movie: movie,
                      titleLength: 50,
                    );
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Rated Movies',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        MovieRepository().fetchMovies('top_rated').then(
                            (value) => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PageWithMoviesList(
                                    title: 'Top Rated',
                                    movies: value,
                                  ),
                                )));
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.grey),
                      ))
                ],
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  widget.topRatedMovies.length,
                  (index) => ScrollingWidgetWithMovies(
                    image: widget.topRatedMovies[index].poster_path,
                    height: 200,
                    width: 150,
                    widget: widget,
                    movie: widget.topRatedMovies[index],
                    titleLength: 20,
                  ),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Movies',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        MovieRepository().getTrendingMovies().then((value) =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PageWithMoviesList(
                                title: 'Trending',
                                movies: value,
                              ),
                            )));
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(color: Colors.grey),
                      ))
                ],
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                    widget.topRatedMovies.length,
                    (index) => ScrollingWidgetWithMovies(
                          image: widget.trendingMovies[index].poster_path,
                          height: 200,
                          width: 150,
                          widget: widget,
                          movie: widget.trendingMovies[index],
                          titleLength: 20,
                        ))
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          prefs.setBool('logged_in', false);
          setState(() {
            moviesBloc = MoviesBloc(MovieRepository())
              ..add(FetchMoviesWithGenreId(genreId));
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ));
        },
      ),
    );
  }
}
