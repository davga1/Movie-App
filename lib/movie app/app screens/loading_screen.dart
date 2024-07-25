import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/image.jpg'),fit: BoxFit.cover)),
    child:  Center(
        child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),child:const Text(
          'Welcome to Movie House\n Enjoy Your Time!',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ) ,) 
        ,
        ),
      ),
    );
  }
}
