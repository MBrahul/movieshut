import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieshut/homemovies.dart';
import 'package:movieshut/login.dart';
import 'package:movieshut/searchmovies.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  bool isLoaded = true;
  bool isSearched = true;
  List trendingMovies = [];
  List topRatedMovies = [];
  List nowPlayingMovies = [];
  List searchedMovies = [];
  List upcomingMovies = [];

  var query = TextEditingController();

  getTrendingMovies() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=aa13bbbb8c953d043bf620f8d887ae33&language=en-US&page=2'));
    var res = jsonDecode(response.body);
    trendingMovies = res['results'];
  }

  getTopRatedMovies() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=aa13bbbb8c953d043bf620f8d887ae33&language=en-US&page=1'));
    var res = jsonDecode(response.body);
    topRatedMovies = res['results'];
  }

  getNowPlayingMovies() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=aa13bbbb8c953d043bf620f8d887ae33&language=en-US&page=1'));
    var res = jsonDecode(response.body);
    nowPlayingMovies = res['results'];
  }

  getUpcomingMovies() async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=aa13bbbb8c953d043bf620f8d887ae33&language=en-US&page=1'));
    var res = jsonDecode(response.body);
    upcomingMovies = res['results'];
  }

  getSearchedMovies(query) async {
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=bcc4ff10c2939665232d75d8bf0ec093&query=${query.text.toString()}'));
    var res = jsonDecode(response.body);

    searchedMovies = res['results'];
  }

  @override
  void initState() {
    super.initState();
    getTrendingMovies();
    getTopRatedMovies();
    getNowPlayingMovies();
    getUpcomingMovies();
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (query.text.toString().isNotEmpty) {
        getSearchedMovies(query);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Movieshut',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      controller: query,
                      style: const TextStyle(color: Colors.white, fontSize: 23),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.amber,
                            size: 35,
                          ),
                          fillColor: Colors.white38,
                          filled: true,
                          hintText: "What's New",
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.white12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.white))),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(24)),
                    child: IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: Colors.black,
                          size: 30,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
          backgroundColor: Colors.black,
          toolbarHeight: 130,
        ),
        body: (query.text.toString().isEmpty)
            ? HomeMovies(trendingMovies, topRatedMovies, nowPlayingMovies,
                upcomingMovies)
            : SearchMovies(searchedMovies));
  }
}
