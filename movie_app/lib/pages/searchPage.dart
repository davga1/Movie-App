import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Fetch/fetchMovie.dart';
import '../constants/consts.dart';
import 'moviePage.dart';

String query = '';
List results = [];
String defaultSearch = '';
int _index = 0;
int page = 1;
int totalPagesCount = 0;
String language = eng;

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  void makeResultsEmpty() async {
    results = await searchMovie(defaultSearch, language, page, 'results');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    makeResultsEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: TextField(
            decoration: const InputDecoration(hintText: 'Search'),
            onSubmitted: (value) async => {
              results = await searchMovie(value, language, page, 'results'),
              totalPagesCount =
                  await searchMovie(value, language, page, 'total_pages'),
              query = value,
              setState(() {})
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) => Card(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => moviePage(
                          title: results[index]['title'],
                          overview: results[index]['overview'],
                          image: results[index]['poster_path'],
                          backgroundImage: results[index]['backdrop_path'],
                          voteCount: results[index]['vote_count'],
                          voteAverage: results[index]['vote_average'],
                          id: results[index]['id']
                          // pictures: [pictures],
                          ),
                    ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w780/${results[index]['poster_path']}'),
                    ),
                    title: Text(results[index]['title']),
                    trailing: Text('⭐${results[index]['vote_average']}'),
                  ),
                )),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (_index >= 5) {
                          setState(() {
                            _index -= 5;
                          });
                        }
                      },
                      child: Icon(CupertinoIcons.back)),
                  ...List.generate(
                      totalPagesCount > 5 ? 5 : totalPagesCount,
                      (index) => TextButton(
                          onPressed: () async {
                            page = index + 1;
                            results = await searchMovie(
                                query, language, page, 'results');
                            setState(() {});
                            print(totalPagesCount);
                          },
                          child: Text('${index + _index + 1}'))),
                  TextButton(
                      onPressed: () {
                        _index + 5 > totalPagesCount ? _index : _index += 5;
                        setState(() {});
                      },
                      child: Icon(CupertinoIcons.forward))
                ],
              ),
            )
          ],
        ));
  }
}
