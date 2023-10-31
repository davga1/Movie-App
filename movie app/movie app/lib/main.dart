import 'package:app_movie/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = '2517e1e63acc7e01b602eca97a064d99';
String language = 'en-US';
int page = 1;
List movies = [];
int totalPages = 0;
String lang = 'English';
List movies_search = [];
int pages_search = 0;
String genre = 'popular';
bool pageIsOnSearchPage = false;
int count = 0;

void main() => runApp(const CupertinoApp(
      home: App(),
    ));

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  void getMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$genre?api_key=$apiKey&language=$language&page=$page'));
    final decodedJson = jsonDecode(response.body);
    movies = decodedJson['results'];
    totalPages = decodedJson['total_pages'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: CupertinoContextMenu(
              actions: [
                CupertinoContextMenuAction(
                  child: const Text('English'),
                  onPressed: () => setState(() {
                    lang = 'English';
                    language = 'en-US';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
                CupertinoContextMenuAction(
                  child: const Text('Russian'),
                  onPressed: () => setState(() {
                    lang = 'Russian';
                    language = 'ru-RU';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
                CupertinoContextMenuAction(
                  child: const Text('French'),
                  onPressed: () => setState(() {
                    lang = 'French';
                    language = 'fr-FR';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
              ],
              child: Text(lang),
            ),
            middle: CupertinoContextMenu(
              actions: [
                CupertinoContextMenuAction(
                  child: const Text('Popular Movies'),
                  onPressed: () => setState(() {
                    genre = 'popular';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
                CupertinoContextMenuAction(
                  child: const Text('Now Playing Movies'),
                  onPressed: () => setState(() {
                    genre = 'now_playing';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
                CupertinoContextMenuAction(
                  child: const Text('Upcoming Movies'),
                  onPressed: () => setState(() {
                    genre = 'upcoming';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
                CupertinoContextMenuAction(
                  child: const Text('Top Rated Movies'),
                  onPressed: () => setState(() {
                    genre = 'top_rated';
                    getMovies();
                    Navigator.of(context).pop();
                  }),
                ),
              ],
              child: Text(
                  '${genre.replaceFirst(genre[0], genre[0].toUpperCase())} Movies'),
            ),
            trailing: CupertinoButton(
              onPressed: () {
                setState(() {
                  pageIsOnSearchPage = true;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const searchPage(),
                ));
              },
              child: const Icon(CupertinoIcons.search),
            )),
        child: Scaffold(
            bottomNavigationBar: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (count > 0) {
                          setState(() {
                            count -= 100;
                          });
                        }
                      },
                      icon: const Icon(CupertinoIcons.back)),
                  ...List.generate(
                      totalPages > 100? 100 : totalPages,
                      (index) => TextButton(
                          onPressed: () {
                            page = index + count + 1;
                            getMovies();
                          },
                          child: Text('${index + count + 1}'))),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          count += 100;
                        });
                      },
                      icon: const Icon(CupertinoIcons.forward))
                ],
              ),
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CupertinoPageScaffold(
                          child: CustomScrollView(
                        slivers: [
                          CupertinoSliverNavigationBar(
                            largeTitle: Text(movies[index]['title']),
                          ),
                          SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Vote count:${movies[index]['vote_count']}'),
                                        Text(
                                            'Average:${movies[index]['vote_average'] / 1}')
                                      ]),
                                  Flexible(
                                    child: Image.network(
                                        'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}'),
                                  ),
                                  Text(movies[index]['overview'])
                                ],
                              ))
                        ],
                      )),
                    )),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}')),
                    title: Text(movies[index]['title']),
                    trailing: Text('⭐ ${movies[index]['vote_average'] / 1}'),
                    //End of main page
                  ),
                ),
              ),
            )));
  }
}