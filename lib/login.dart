import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movieshut/main.dart';
import 'package:movieshut/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool value = true;
  var email = TextEditingController();
  var password = TextEditingController();
  String error = "";
  bool obsure = true;
  String text = "SHOW";
  loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: MyHomePage(), type: PageTransitionType.bottomToTop));
      if (!value) {
        Timer(const Duration(seconds: 1), () async {
          await FirebaseAuth.instance.signOut();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = "No user found for this email.";
        setState(() {});
        Timer(const Duration(seconds: 3), () {
          setState(() {
            error = "";
          });
        });
      } else if (e.code == 'wrong-password') {
        error = "Wrong password provided.";
        setState(() {});
        Timer(const Duration(seconds: 3), () {
          setState(() {
            error = "";
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Movieshut',
          style: TextStyle(
              color: Colors.amber, fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        height: double.infinity,
        width: double.infinity,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 15),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white, fontSize: 22),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.amber,
                  ),
                  fillColor: Colors.white10,
                  filled: true,
                  label: Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12))),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: password,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              cursorColor: Colors.white,
              obscureText: obsure,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.amber,
                  ),
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        if (obsure) {
                          obsure = false;
                          text = "HIDE";
                        } else {
                          obsure = true;
                          text = "SHOW";
                        }
                      });
                    },
                    child: Text(
                      text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  fillColor: Colors.white10,
                  filled: true,
                  label: const Text(
                    'Password',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12))),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.amber,
                        side: const BorderSide(color: Colors.white),
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value!;
                          });
                          // print(value);
                        }),
                    const Text(
                      "Remember me",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15, color: Colors.white54),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Signup();
                    }));
                  },
                  child: const Text(
                    "Sign-up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
