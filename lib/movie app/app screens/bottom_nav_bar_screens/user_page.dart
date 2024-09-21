import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(email),
      ),
    );
  }
}
