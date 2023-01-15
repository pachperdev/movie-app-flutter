import 'dart:convert';

import 'package:movie_app/models/models.dart';

class RecommendResponse {
  RecommendResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory RecommendResponse.fromJson(String str) =>
      RecommendResponse.fromMap(json.decode(str));

  factory RecommendResponse.fromMap(Map<String, dynamic> json) =>
      RecommendResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
