import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:movieshut/login.dart';
import 'package:movieshut/main.dart';

class Splash extends StatefulWidget {
  bool isLogin;
  Splash(this.isLogin);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1600), () {
      (widget.isLogin)
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
              return MyHomePage();
            }))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
              return Login();
            }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
            child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'Movieshut',
              textStyle: const TextStyle(
                  color: Colors.amber,
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'font1'),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          isRepeatingAnimation: false,
        )),
      ),
    );
  }
}
