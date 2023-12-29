import 'package:flutter/material.dart';
import 'package:movie_app/fetch/fetchActorData.dart';

class actorPage extends StatefulWidget {
  actorPage({
    super.key,
    required this.name,
    required this.photo,
    required this.birthday,
    required this.deathday,
    required this.backgroundImage,
    required this.text,
  });

  final String name;
  final String photo;
  final String birthday;
  final dynamic deathday;
  final String backgroundImage;
  final String text;

  @override
  State<actorPage> createState() => _actorPageState();
}

class _actorPageState extends State<actorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}'s biography"),
      ),
      body:   Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.fitHeight,
    image: NetworkImage(
    'https://image.tmdb.org/t/p/w780/${widget.backgroundImage}'))),
    child:SingleChildScrollView(scrollDirection: Axis.vertical,child:Center(
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w154${widget.photo}')),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Name: ${widget.name}',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Text(''),
                    Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('Birthday : ${widget.birthday}',
                            style: TextStyle(color: Colors.white))),
                    Text(''),
                    Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'Death day : ${widget.deathday == null ? 'Live now' : widget.deathday.toString()}',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )
              ],
            ),

            Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  widget.text,
                  style: TextStyle(color: Colors.white),
                ))],)
        ),
      )),
    );
  }
}
