import 'package:flutter/material.dart';
import 'package:movie_app/Fetch/fetchPictures.dart';
import 'package:movie_app/fetch/fetchActors.dart';
import 'package:movie_app/pages/mainPage.dart';
import '../constants/consts.dart';

Color color = Colors.white;
List pictures = [];
List actors = [];
String text = 'Pictures';

class moviePage extends StatefulWidget {
  moviePage({
    super.key,
    required this.title,
    required this.overview,
    required this.image,
    required this.backgroundImage,
    required this.voteCount,
    required this.voteAverage,
    required this.id,
    // required this.pictures,
  });

  late final String title;
  final String overview;
  final String image;
  final String backgroundImage;
  final int voteCount;
  final double voteAverage;
  final int id;

  @override
  State<moviePage> createState() => _moviePageState();
}

class _moviePageState extends State<moviePage> {
  constructor(String title, String overview, String image,
      String backgroundImage, int id) {}

  getImages() async {
    pictures = await getPictures(widget.id);
    actors = await getActors(widget.id);
    text = 'Pictures';
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 50),
        ),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w780/${widget.backgroundImage}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(''),
              const Text(''),
              const Text(''),
              const Text(''),
              const Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                    child: Text('Vote count: ${widget.voteCount}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(0, 10, 25, 0),
                    child: Text('Vote average: ${widget.voteAverage}',
                        style: const TextStyle(color: Colors.white)),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: Image.network(
                    'https://image.tmdb.org/t/p/original${widget.image}'),
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(25),
                  child: Text(
                    widget.overview,
                    style: const TextStyle(color: Colors.white),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextButton(
                      child: Text(
                          language == eng
                              ? 'Pictures'
                              : language == rus
                                  ? 'Картинки'
                                  : 'Photos',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          text = 'Pictures';
                        });
                      },
                    ),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextButton(
                        child: Text(
                            language == eng
                                ? 'Actors'
                                : language == rus
                                    ? 'Актёры'
                                    : 'Actors',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            text = 'Actors';
                          });
                        },
                      ))
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                    children: [
                      ...List.of(List.generate(
                          text == 'Pictures' ? pictures.length : actors.length,
                          (index) => Image(
                              image: text == 'Pictures'
                                  ? NetworkImage(
                                      'https://image.tmdb.org/t/p/w300${pictures[index]['file_path']}')
                                  : NetworkImage(
                                      'https://image.tmdb.org/t/p/w300${actors[index]['profile_path']}'))))
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
