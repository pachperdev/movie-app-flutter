import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    // ignore: avoid_print
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    // ignore: avoid_print
    print('getOnDisplayMovies');
  }
}
