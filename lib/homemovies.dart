import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieshut/movie.dart';

class HomeMovies extends StatefulWidget {
  List trendingMovies;
  List nowPlayingMovies;
  List topRatedMovies;
  List upcomingMovies;
  HomeMovies(this.trendingMovies, this.topRatedMovies, this.nowPlayingMovies,
      this.upcomingMovies);

  @override
  State<HomeMovies> createState() => _HomeMoviesState();
}

class _HomeMoviesState extends State<HomeMovies> {
  bool isLoaded = false;

  isDataLoaded() {
    if (widget.nowPlayingMovies != [] &&
        widget.trendingMovies != [] &&
        widget.topRatedMovies != [] &&
        widget.upcomingMovies != []) {
      isLoaded = true;
      setState(() {});
    } else {
      isDataLoaded();
    }
  }

  @override
  void initState() {
    super.initState();
    isDataLoaded();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 6, top: 5),
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // for trending movies
                Row(
                  children: const [
                    Text(
                      "Trending Movies",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                  height: 230,
                  padding: const EdgeInsets.only(top: 7),
                  // color: Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  var movie = widget.trendingMovies[index];
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Movie(movie);
                                  }));
                                },
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${widget.trendingMovies[index]["poster_path"]}",
                                  width: 130,
                                ),
                              ),
                              Text(
                                (widget.trendingMovies[index]['original_title'])
                                            .toString()
                                            .length >
                                        20
                                    ? (widget.trendingMovies[index]
                                            ['original_title'])
                                        .toString()
                                        .substring(0, 20)
                                    : widget.trendingMovies[index]
                                        ['original_title'],
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      );
                    },
                    itemCount: widget.trendingMovies.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // for top rated movies
                Row(
                  children: const [
                    Text(
                      "Top Rated Movies",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  height: 230,
                  padding: const EdgeInsets.only(top: 7),
                  // color: Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var movie = widget.topRatedMovies[index];
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Movie(movie);
                                  }));
                                },
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${widget.topRatedMovies[index]["poster_path"]}",
                                  width: 130,
                                ),
                              ),
                              Text(
                                (widget.topRatedMovies[index]['original_title'])
                                            .toString()
                                            .length >
                                        20
                                    ? (widget.topRatedMovies[index]
                                            ['original_title'])
                                        .toString()
                                        .substring(0, 20)
                                    : widget.topRatedMovies[index]
                                        ['original_title'],
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      );
                    },
                    itemCount: widget.topRatedMovies.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // for now playing movies
                Row(
                  children: const [
                    Text(
                      "Now Playing",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  height: 230,
                  padding: const EdgeInsets.only(top: 7),
                  // color: Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var movie = widget.nowPlayingMovies[index];
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Movie(movie);
                                  }));
                                },
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${widget.nowPlayingMovies[index]["poster_path"]}",
                                  width: 130,
                                ),
                              ),
                              Text(
                                (widget.nowPlayingMovies[index]
                                                ['original_title'])
                                            .toString()
                                            .length >
                                        20
                                    ? (widget.nowPlayingMovies[index]
                                            ['original_title'])
                                        .toString()
                                        .substring(0, 20)
                                    : widget.nowPlayingMovies[index]
                                        ['original_title'],
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      );
                    },
                    itemCount: widget.nowPlayingMovies.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //  upcoming movies
                Row(
                  children: const [
                    Text(
                      "Upcoming Movies",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  height: 230,
                  padding: const EdgeInsets.only(top: 7),
                  // color: Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var movie = widget.upcomingMovies[index];
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Movie(movie);
                                  }));
                                },
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${widget.upcomingMovies[index]["poster_path"]}",
                                  width: 130,
                                ),
                              ),
                              Text(
                                (widget.upcomingMovies[index]['original_title'])
                                            .toString()
                                            .length >
                                        20
                                    ? (widget.upcomingMovies[index]
                                            ['original_title'])
                                        .toString()
                                        .substring(0, 20)
                                    : widget.upcomingMovies[index]
                                        ['original_title'],
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      );
                    },
                    itemCount: widget.upcomingMovies.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ));
    } else {
      return Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 6, top: 5),
        color: Colors.black,
        child: const SpinKitDualRing(color: Colors.amber),
      );
    }
  }
}
