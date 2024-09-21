import 'package:bloc_test/widgets/socialSignInButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../movie app/functions.dart';

Widget buildSignInForm(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Text(
            'Movie House',
            style: TextStyle(color: Colors.lightBlue, fontSize: 25),
          ),
          const SizedBox(height: 20),
          const Text('Sign in',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          const Text('Enter your credentials',
              style: TextStyle(color: Colors.grey, fontSize: 18)),
          const SizedBox(height: 10),
          buildTextField('Enter your Email'),
          const SizedBox(height: 10),
          buildTextField('Enter your Password'),
          const SizedBox(height: 10),
          buildSignInButton(),
          buildDividerWithText('OR'),
          buildSocialSignInButton(
            icon: FontAwesomeIcons.google,
            color: Colors.red,
            text: 'Continue With Google',
            onTap: () => handleGoogleSignIn(context),
          ),
          const SizedBox(height: 10),
          buildSocialSignInButton(
            icon: FontAwesomeIcons.facebook,
            color: Colors.blueAccent,
            text: 'Continue With Facebook',
            onTap: () => handleFacebookSignIn,
          ),
          buildSignUpText(),
        ],
      ),
    ),
  );
}

Widget buildTextField(String hint) {
  return TextField(
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}

Widget buildSignInButton() {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(10),
    ),
    child: GestureDetector(
      onTap: () => handleSignIn,
      child: const Align(
        alignment: Alignment.center,
        child: Text('Sign in',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ),
  );
}

Widget buildDividerWithText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Expanded(
          child: Divider(thickness: 1, endIndent: 10, color: Colors.grey)),
      Text(text, style: const TextStyle(color: Colors.grey)),
      const Expanded(
          child: Divider(indent: 10, thickness: 1, color: Colors.grey)),
    ],
  );
}

Widget buildSocialSignInButton({
  required IconData icon,
  required Color color,
  required String text,
  required VoidCallback onTap,
}) {
  return SocialSignInButton(
    icon: Icon(icon, color: color),
    text: text,
    onTap: onTap,
  );
}

Widget buildSignUpText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have an account? ",
          style: TextStyle(color: Colors.white)),
      GestureDetector(
        child: const Text('Sign up', style: TextStyle(color: Colors.blue)),
      ),
    ],
  );
}
