import 'dart:convert';

import 'package:movie_app/models/models.dart';

class TopRatedResponse {
  TopRatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory TopRatedResponse.fromJson(String str) =>
      TopRatedResponse.fromMap(json.decode(str));

  factory TopRatedResponse.fromMap(Map<String, dynamic> json) =>
      TopRatedResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
