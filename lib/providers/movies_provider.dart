import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'b113e1523cd29bda4970cfc13c98faf5';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  MoviesProvider() {
    // ignore: avoid_print
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    // ignore: avoid_print
    print('getOnDisplayMovies');

    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodeData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      // ignore: avoid_print
      print(decodeData);
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
