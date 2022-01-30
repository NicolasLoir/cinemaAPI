class Film {
  late int? id;
  String? titre;
  double? note;
  String? dateDeSortie;
  String? resume;
  String? urlAffiche;

  Film.fromJson(Map<String, dynamic> chaineJson) {
    id = chaineJson['id'];
    titre = chaineJson['title'];
    note = chaineJson['vote_average'] * 1.0;
    dateDeSortie = chaineJson['release_date'];
    resume = chaineJson['overview'];
    urlAffiche = chaineJson['poster_path'];
  }
}
