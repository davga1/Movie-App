import 'package:flutter/material.dart';
import 'package:movie_app/pages/mainPage.dart';

void main() =>
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Main()));

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const mainPage();
  }
}