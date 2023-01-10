import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';
import 'package:movie_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'b113e1523cd29bda4970cfc13c98faf5';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    // ignore: avoid_print
    // print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    // ignore: avoid_print
    // print('getOnDisplayMovies');

    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
      onDisplayMovies = nowPlayingResponse.results;
      // ignore: avoid_print
      // print(onDisplayMovies[0].title);
      notifyListeners();
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getPopularMovies() async {
    // ignore: avoid_print
    // print('getOnDisplayMovies');

    var url = Uri.https(_baseUrl, '/3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final popularResponse = PopularResponse.fromJson(response.body);
      popularMovies = [...popularMovies, ...popularResponse.results];
      // ignore: avoid_print
      // print(popularMovies[1].title);
      notifyListeners();
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
