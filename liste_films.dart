import 'package:flutter/material.dart';
import 'package:tp4_cinema/detail_film.dart';
import 'package:tp4_cinema/http_helper.dart';

class ListeFilms extends StatefulWidget {
  const ListeFilms({Key? key}) : super(key: key);

  @override
  _ListeFilmsState createState() => _ListeFilmsState();
}

class _ListeFilmsState extends State<ListeFilms> {
  Icon iconVisible = const Icon(Icons.search);
  Widget barreRecherche = const Text('Films');

  String resultat = "oui";
  late List films;
  late int nombreDeFilms = 0;
  HttpHelper? helper;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String imageParDefaut =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  @override
  void initState() {
    helper = HttpHelper();
    _initialiser();
    super.initState();
  }

  Future _initialiser() async {
    var _films = await helper!.recevoirNouveauxFilms();
    setState(() {
      nombreDeFilms = _films.length;
      films = _films;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: barreRecherche,
          actions: <Widget>[
            IconButton(
              icon: iconVisible,
              onPressed: () {
                setState(() {
                  if (iconVisible.icon == Icons.search) {
                    iconVisible = const Icon(Icons.cancel);
                    barreRecherche = TextField(
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      onSubmitted: (String texte) {
                        rechercher(texte);
                      },
                    );
                  } else {
                    setState(() {
                      iconVisible = const Icon(Icons.search);
                      barreRecherche = const Text('Films');
                    });
                  }
                });
              },
            ),
          ],
        ),
        body: createListFilm());
  }

  Future rechercher(texte) async {
    films = await helper!.rechercherFilms(texte);
    setState(() {
      nombreDeFilms = films.length;
      films = films;
    });
  }

  Widget createListFilm() {
    return ListView.builder(
      itemCount: nombreDeFilms,
      itemBuilder: (BuildContext context, int position) {
        NetworkImage image;
        if (films[position].urlAffiche != null) {
          image = NetworkImage(iconBase + films[position].urlAffiche);
        } else {
          image = NetworkImage(imageParDefaut);
        }
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: image,
            ),
            title: Text(films[position].titre),
            subtitle: Text('Date de sortie : ' +
                films[position].dateDeSortie +
                ' - Note : ' +
                films[position].note.toString()),
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => DetailFilm(
                        films[position],
                      ));
              Navigator.push(context, route);
            },
          ),
        );
      },
    );
  }
}
