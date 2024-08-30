import 'package:bloc_test/movie%20app/app%20screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black45,
      body: ListView(
        children: [
          Container(
            height: height / 3,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                image: DecorationImage(
                    image: AssetImage('assets/collage.jpg'), fit: BoxFit.fill)),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    'Movie House',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Text(
                    'Enter your credentials',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter your Email',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter your Password',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text('Sign in',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            onTap: () {
                              prefs.setBool('logged_in', true);
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const MovieApp(),
                              ));
                            },
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Divider(
                              thickness: 1,
                              endIndent: 10,
                              color: Colors.grey,
                            )),
                            Text(
                              'OR',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Expanded(
                                child: Divider(
                              indent: 10,
                              thickness: 1,
                              color: Colors.grey,
                            )),
                          ],
                        ),
                        SocialSignInButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                          text: 'Continue With Google',
                          onTap: () {
                            prefs.setBool('logged_in', true);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MovieApp(),
                            ));
                          },
                        ),
                        const SizedBox(height: 10),
                        SocialSignInButton(
                          icon: const Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blueAccent,
                          ),
                          text: 'Continue With Facebook',
                          onTap: () {
                            prefs.setBool('logged_in', true);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MovieApp(),
                            ));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton(
      {required this.onTap, required this.icon, required this.text, super.key});

  final String text;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: onTap,
        child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(
                  width: 5,
                ),
                Text(text, style: const TextStyle(fontSize: 15)),
              ],
            )),
      ),
    );
  }
}
