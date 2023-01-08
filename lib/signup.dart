import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieshut/home.dart';
import 'package:movieshut/login.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var email = TextEditingController();
  var password = TextEditingController();
  String error = '';
  bool obsure = true;
  String text = "SHOW";
  FirebaseFirestore db = FirebaseFirestore.instance;
  // creating new user
  createUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      db
          .collection('users')
          .add({"email": email.text.toString()}).then((value) => print(value));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const Home();
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = "The password provided is too weak";
        setState(() {});
        Timer(const Duration(seconds: 3), () {
          setState(() {
            error = "";
          });
        });
      } else if (e.code == 'email-already-in-use') {
        error = "The account already exists for this email";
        setState(() {});
        Timer(const Duration(seconds: 3), () {
          setState(() {
            error = "";
          });
        });
      }
    } catch (e) {
      error = "Login With Correct Credentials";
      setState(() {});
      Timer(const Duration(seconds: 3), () {
        setState(() {
          error = "";
        });
      });
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
              height: 16,
            ),
            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white, fontSize: 22),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    (Icons.email),
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
              height: 18,
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
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  createUser();
                },
                child: const Text(
                  "Sign-up",
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
                  "Have an account?",
                  style: TextStyle(fontSize: 15, color: Colors.white54),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: const Text(
                    "Log-in",
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
