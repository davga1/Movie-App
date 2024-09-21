import 'package:flutter/material.dart';

import '../main.dart';
import 'auth/google_auth.dart';

String truncateName(String name, int maxLength) {
  if (name.length > maxLength) {
    return '${name.substring(0, maxLength - 3)}...';
  }
  return name;
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0]} hr ${parts[1]} min';
}

void handleSignIn(BuildContext context) {
  prefs.setBool('logged_in', true);
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const MovieApp(userEmail: ''),
  ));
}

void handleGoogleSignIn(BuildContext context) {
  print('clicked');
  signInWithGoogle().then((value) {
    if (context.mounted) {
      prefs.setString('email', value.user!.email!);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MovieApp(userEmail: value.user!.email!),
      ));
      prefs.setBool('logged_in', true);
    }
  }).catchError((error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
    }
  });
}

void handleFacebookSignIn(BuildContext context) {
  prefs.setBool('logged_in', true);
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const MovieApp(userEmail: ''),
  ));
}
