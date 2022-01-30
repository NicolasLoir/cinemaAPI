import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:tp4_cinema/film.dart';

class HttpHelper {
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlCmd = '/upcoming?';
  final String urlKey = 'api_key=87a5ba0670fe18f735330ba3c2e372e9';
  final String urlLangage = '&language=fr-FR';

  final String urlRecherche =
      'https://api.themoviedb.org/3/search/movie?api_key=87a5ba0670fe18f735330ba3c2e372e9&language=fr-FR&query=';

  Future<List> recevoirNouveauxFilms() async {
    String urlNouveauxFilms = urlBase + urlCmd + urlKey + urlLangage;
    http.Response resultat = await http.get(Uri.parse(urlNouveauxFilms));

    if (resultat.statusCode == HttpStatus.ok) {
      final chaineJson = json.decode(resultat.body);
      final filmsMap = chaineJson['results'];
      // print("filmsMap");
      // print(filmsMap);

      List films = filmsMap.map((i) {
        print(i);
        return Film.fromJson(i);
      }).toList();
      films.sort((a, b) => b.dateDeSortie.compareTo(a.dateDeSortie));

      return films;
    } else {
      return [];
    }
  }

  Future<List> rechercherFilms(String titre) async {
    final String query = urlRecherche + titre;
    http.Response resultat = await http.get(Uri.parse(query));
    if (resultat.statusCode == HttpStatus.ok) {
      final reponseJson = json.decode(resultat.body);
      final filmsMap = reponseJson['results'];
      List films = filmsMap.map((i) => Film.fromJson(i)).toList();
      return films;
    } else {
      return [];
    }
  }
}
