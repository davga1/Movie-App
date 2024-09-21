import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
import '../../widgets/buildSignInForm.dart';
import '../../widgets/headerImage.dart';
import '../auth/google_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        children: [
          headerImage(height),
          const SizedBox(height: 10),
          buildSignInForm(context),
        ],
      ),
    );
  }
}
