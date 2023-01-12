import 'dart:convert';

import 'package:movie_app/models/models.dart';

class UpcomingResponse {
  UpcomingResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory UpcomingResponse.fromJson(String str) =>
      UpcomingResponse.fromMap(json.decode(str));

  factory UpcomingResponse.fromMap(Map<String, dynamic> json) =>
      UpcomingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
