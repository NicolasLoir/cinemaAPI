// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tp4_cinema/film.dart';

class DetailFilm extends StatelessWidget {
  final Film un_film;

  const DetailFilm(this.un_film, {Key? key}) : super(key: key);

  final String iconBase = 'https://image.tmdb.org/t/p/w400/';

  @override
  Widget build(BuildContext context) {
    String chemin_img;
    double largeurScreen;
    double hauteurScreen;
    if (un_film.urlAffiche != null) {
      chemin_img = iconBase + un_film.urlAffiche!;
    } else {
      chemin_img =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          un_film.titre!,
          maxLines: 3,
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints contraints) {
        hauteurScreen = contraints.maxHeight;
        largeurScreen = contraints.maxWidth;
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image(
                    image: NetworkImage(chemin_img),
                    height: hauteurScreen / 1.5,
                    fit: BoxFit.fill),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(un_film.resume!),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
