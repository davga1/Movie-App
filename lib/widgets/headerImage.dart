import 'package:flutter/material.dart';

Widget headerImage(double height) {
  return Container(
    height: height / 3,
    width: double.infinity,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      image: DecorationImage(
        image: AssetImage('assets/collage.jpg'),
        fit: BoxFit.fill,
      ),
    ),
  );
}