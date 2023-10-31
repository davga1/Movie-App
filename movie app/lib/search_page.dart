import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

String apiKey = '2517e1e63acc7e01b602eca97a064d99';
int page_search = 1;
int pages_count_search = 0;
List movies_search = [];
String _query = '';
int _index = 0;
int _count = 0;
class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  void searchMovies(String query) async {
    _query = query;
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=$language&page=$page_search&query=$query'));
    final decodedJson = jsonDecode(response.body);
    movies_search = decodedJson['results'];
    pages_count_search = decodedJson['total_pages'];
    setState(() {});
  }

  @override
  void initState() {
    searchMovies('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: CupertinoSearchTextField(
          onSubmitted: (value) => searchMovies(value),
        )),
        child: Scaffold(
          bottomNavigationBar: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                    pages_count_search == 0 ? 0 : pages_count_search,
                    (index) => TextButton(
                        onPressed: () {
                          page_search = index + 1;
                          searchMovies(_query);
                        },
                        child: Text(' ${index + 1}'))),
              ],
            ),
          ),
          body: ListView.builder(
            itemCount: movies_search.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CupertinoPageScaffold(
                      child: CustomScrollView(
                    slivers: [
                      CupertinoSliverNavigationBar(
                        largeTitle: Text(movies_search[index]['title']),
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
                                        'Vote count:${movies_search[index]['vote_count']}'),
                                    Text(
                                        'Average: ${movies_search[index]['vote_average'] / 1}')
                                  ]),
                              Image.network(
                                  'https://image.tmdb.org/t/p/w500${movies_search[index]['poster_path']}'),
                              Text(movies_search[index]['overview'])
                            ],
                          ))
                    ],
                  )),
                )),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movies_search[index]['poster_path']}')),
                title: Text(movies_search[index]['title']),
                trailing: Text('⭐ ${movies_search[index]['vote_average'] / 1}'),
                //End of main page
              ),
            ),
          ),
        ));
  }
}