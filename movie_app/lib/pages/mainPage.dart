import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/fetch/fetchData.dart';
import 'package:movie_app/pages/moviePage.dart';
import 'package:movie_app/pages/searchPage.dart';
import 'package:country_flags/country_flags.dart';
import '../constants/consts.dart';


class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

int page = 1;
int _index = 0;
int totalPagesCount = 0;
List list = [];
String language = eng;
CountryFlag _value = flags.first;
String genre = genres.first;

class _mainPageState extends State<mainPage> {
  void getList() async {
    list = await fetchData(genre, eng, page, 'results');
    totalPagesCount = await fetchData(genre, eng, page, 'total_pages');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<CountryFlag>(
                        dropdownColor: Colors.black54,
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            value: flags.elementAt(0),
                            child: CountryFlag.fromCountryCode(
                              'US',
                              height: 25,
                              width: 25,
                            ),
                            onTap: () async {
                              language = eng;
                              list = await fetchData(
                                  genre, language, page, 'results');
                              setState(() {});
                            },
                          ),
                          DropdownMenuItem(
                            value: flags.elementAt(1),
                            child: CountryFlag.fromCountryCode(
                              'FR',
                              height: 25,
                              width: 25,
                            ),
                            onTap: () async {
                              language = french;
                              list = await fetchData(
                                  genre, language, page, 'results');
                              setState(() {});
                            },
                          ),
                          DropdownMenuItem(
                            value: flags.elementAt(2),
                            child: CountryFlag.fromCountryCode(
                              'RU',
                              height: 25,
                              width: 25,
                            ),
                            onTap: () async {
                              language = rus;
                              list = await fetchData(
                                  genre, language, page, 'results');
                              setState(() {});
                            },
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        }),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DropdownButton<String>(
                  value: genre,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.black54,
                  items: [
                    DropdownMenuItem(
                      value: genres.elementAt(0),
                      child: const Text('Popular movies'),
                      onTap: () async {
                        genre = 'popular';
                        page = 1;
                        list =
                            await fetchData(genre, language, page, 'results');
                        setState(() {});
                      },
                    ),
                    DropdownMenuItem(
                      value: genres.elementAt(1),
                      child: const Text('Now Playing movies'),
                      onTap: () async {
                        genre = 'now_playing';
                        page = 1;
                        list =
                            await fetchData(genre, language, page, 'results');
                        setState(() {});
                      },
                    ),
                    DropdownMenuItem(
                      value: genres.elementAt(2),
                      child: const Text('Upcoming movies'),
                      onTap: () async {
                        genre = 'upcoming';
                        page = 1;
                        list =
                            await fetchData(genre, language, page, 'results');
                        setState(() {});
                      },
                    ),
                    DropdownMenuItem(
                      value: genres.elementAt(3),
                      child: const Text('Top Rated movies'),
                      onTap: () async {
                        genre = 'top_rated';
                        page = 1;
                        list =
                            await fetchData(genre, language, page, 'results');
                        setState(() {});
                      },
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      genre = value!;
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const searchPage(),
                  ))
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          // actions: <Widget>[
          //
          // ],
        ),
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Card(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => moviePage(
                          title: list[index]['title'],
                          overview: list[index]['overview'],
                          image: list[index]['poster_path'],
                          backgroundImage: list[index]['backdrop_path'],
                          voteCount: list[index]['vote_count'],
                          voteAverage: list[index]['vote_average'],
                          id: list[index]['id']),
                    ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w780/${list[index]['poster_path']}'),
                    ),
                    title: Text(list[index]['title']),
                    trailing: Text('⭐${list[index]['vote_average']}'),
                  ),
                )),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        if (_index >= 4) {
                          setState(() {
                            _index -= 4;
                          });
                        }
                      },
                      child: const Icon(CupertinoIcons.back)),
                  ...List.generate(
                      4,
                      (index) => TextButton(
                          onPressed: () async {
                            page = index + 1;
                            list = await fetchData(
                                genre, language, page, 'results');
                            setState(() {});
                          },
                          child: Text('${index + _index + 1}'))),
                  TextButton(
                      onPressed: () {
                        _index + 4 > totalPagesCount ? 4 : _index += 4;
                        setState(() {});
                      },
                      child: const Icon(CupertinoIcons.forward))
                ],
              ),
            )
          ],
        ));
  }
}
