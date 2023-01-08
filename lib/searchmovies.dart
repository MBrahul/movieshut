import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieshut/movie.dart';

class SearchMovies extends StatefulWidget {
  List searchedMovies = [];
  SearchMovies(this.searchedMovies);

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        padding: const EdgeInsets.only(left: 5),
        child: isLoaded
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              var movie = widget.searchedMovies[index];
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Movie(movie);
                              }));
                            },
                            child: Image.network(
                              widget.searchedMovies[index]['poster_path'] !=
                                      null
                                  ? "https://image.tmdb.org/t/p/w500${widget.searchedMovies[index]["poster_path"]}"
                                  : "https://technologers.com/wp-content/uploads/2017/02/Movie-hd-app.png",
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                var movie = widget.searchedMovies[index];
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Movie(movie);
                                }));
                              },
                              child: Text(
                                widget.searchedMovies[index]['original_title'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  );
                },
                itemCount: widget.searchedMovies.length,
              )
            : const SpinKitDualRing(color: Colors.amber));
  }
}
