import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'b113e1523cd29bda4970cfc13c98faf5';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> searchMovies = [];
  List<Movie> recommendMovies = [];
  List<Movie> similarMovies = [];

  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Movie>> moviesRecommend = {};
  Map<int, List<Movie>> similarRecommend = {};

  int _countPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpcomingMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _countPage++;

    final jsonData = await _getJsonData('3/movie/popular', _countPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies() async {
    _countPage++;
    final jsonData = await _getJsonData('3/movie/top_rated', _countPage);

    final topRatedResponse = TopRatedResponse.fromJson(jsonData);
    topRatedMovies = [...topRatedMovies, ...topRatedResponse.results];
    notifyListeners();
  }

  getUpcomingMovies() async {
    _countPage++;
    final jsonData = await _getJsonData('3/movie/upcoming', _countPage);

    final upcomingResponse = UpcomingResponse.fromJson(jsonData);
    upcomingMovies = [...upcomingMovies, ...upcomingResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> getRecommendMovies(int movieId) async {
    final jsonData = await _getJsonData('3/movie/$movieId/recommendations');
    final recommendResponse = RecommendResponse.fromJson(jsonData);

    moviesRecommend[movieId] = recommendResponse.results;

    // return recommendResponse.results;
    return recommendMovies = recommendResponse.results;
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final jsonData = await _getJsonData('3/movie/$movieId/similar');
    final similarResponse = SimilarResponse.fromJson(jsonData);

    similarRecommend[movieId] = similarResponse.results;

    // return recommendResponse.results;
    return similarMovies = similarResponse.results;
  }

  Future<List<Movie>> getSearchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }
}
