import 'dart:convert';

import 'package:movies/src/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'ff93969cdd1fb2c955fe90147e4579a4';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'en-US';
  String _page = '1';

  Future<List<Film>> getInTheaters() async {
    //Generacion de la URL HTTPS

    final _uriS = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lenguage,
      'page': _page,
    });
    return await _processResponse(_uriS);
  }

  Future<List<Film>> getPopulars() async {
    
    //Generacion de la URL HTTPS
    final _uriS = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lenguage,
      'page': _page,
    });
    return await _processResponse(_uriS);
  }

  Future<List<Film>> _processResponse(Uri url) async{

    //Peticion HTTP al servicio.
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    // print('Populares : ${decodeData['results']}'); //Imprime en consola la repuesta del servicio.

    final movies = Movies.fromJsonList(decodeData[
        'results']); //El constructor va a barrer todos las peliculas que viene de la repuesta del servicio, para crear instancias o items segun el modelo

    // print('Popularess : ${movies.items[2].title}'); //Imprime una pelicula en puntual
    return movies.items;
  }
  
}