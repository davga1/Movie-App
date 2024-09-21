import 'package:bloc_test/movie%20app/app%20screens/bottom_nav_bar_screens/main_screen.dart';
import 'package:bloc_test/movie%20app/movies/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../functions.dart';


class MovieDetails extends StatefulWidget {
  final Map<String, dynamic> movie;

  const MovieDetails({required this.movie, super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border_outlined))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                '$imagePath${widget.movie['backdrop_path']}'),
                            fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                truncateName(widget.movie['title'], 30),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Row(
                                children: [
                                  Text(
                                    truncateName(
                                        '${widget.movie['release_date'].toString().substring(0, 4)} Released • ${widget.movie['genres'][0]['name']} • ${durationToString(
                                          widget.movie['runtime'],
                                        )}',
                                        40),
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 15),
                                  ),
                                ],
                              ),
                              Text(
                                '⭐${widget.movie['vote_average'].toStringAsFixed(1)}/10',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                color: Colors.blue,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all()),
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'Watchlist',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all()),
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'Download',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.cloud_download_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReadMoreText(
                    widget.movie['overview'],
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    trimLines: 4,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 300, // Specify a fixed height for the cast section
                    child: CardsWithCast(id: widget.movie['id']),
                  ),
                ],
              )),
        ));
  }
}

class CardsWithCast extends StatefulWidget {
  const CardsWithCast({required this.id, super.key});

  final int id;

  @override
  State<CardsWithCast> createState() => _CardsWithCastState();
}

class _CardsWithCastState extends State<CardsWithCast> {
  int selectedValue = 1;
  String search = 'cast';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: selectedValue == 1 ? Colors.blue : Colors.grey,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedValue = 1;
                      search = 'cast';
                    });
                  },
                  child: Text(
                    'Cast',
                    style: TextStyle(
                      color: selectedValue == 1 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: selectedValue == 2 ? Colors.blue : Colors.grey,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedValue = 2;
                      search = 'crew';
                    });
                  },
                  child: Text(
                    'Director & Crew',
                    style: TextStyle(
                      color: selectedValue == 2 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 260,
          child: FutureBuilder(
            future: MovieRepository().getCastAndDirectors(widget.id),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        10,
                        (index) => Shimmer.fromColors(
                            child: Container(height: 150, width: 100),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final info = snapshot.data;
                if (info != null &&
                    info[search] != null &&
                    info[search].isNotEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...List.generate(
                                info[search].length,
                                (index) => Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://image.tmdb.org/t/p/w1280${info[search][index]['profile_path'] ?? ''}'),
                                                  onError: (_, __) {},
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          width: 100,
                                          height: 150,
                                          child: info[search][index]
                                                      ['profile_path'] ==
                                                  null
                                              ? const Icon(Icons.person,
                                                  color: Colors.white54,
                                                  size: 100)
                                              : null,
                                        ),
                                        Text(
                                          truncateName(
                                              info[search][index]['name'], 18),
                                          style: const TextStyle(
                                              color: Colors.white54),
                                        ),
                                        Text(
                                          truncateName(
                                            info[search][index]['character'] ??
                                                info[search][index]['job'],
                                            15,
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No cast found'));
                }
              }
            },
          ),
        )
      ],
    );
  }
}
