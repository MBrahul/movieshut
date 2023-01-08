import 'package:flutter/material.dart';

class Movie extends StatelessWidget {
  Map movie = {};
  Movie(this.movie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movieshut',
          style: TextStyle(
              color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        height: double.infinity,
        width: double.infinity,
        color: Colors.black87,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.network(
              "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
              height: 350,
              // width: 320,
            ),
            const SizedBox(height: 10),
            Text(
              movie['original_title'],
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie['vote_average'].toString(),
                  style: const TextStyle(color: Colors.amber, fontSize: 20),
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Release Date: ',
                    style: TextStyle(color: Colors.amber, fontSize: 20)),
                Text(movie['release_date'],
                    style: const TextStyle(color: Colors.white, fontSize: 18))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                    children: <TextSpan>[
                  const TextSpan(
                      text: 'Overview : ',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: movie['overview'])
                ]))
          ]),
        ),
      ),
    );
  }
}
