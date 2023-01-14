import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.white,
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.white,
      onPressed: () {
        // Navigator.pushNamed(context, 'home');
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return MovieSliderbuildSuggestions(
      movies: moviesProvider.topRatedMovies,
      title: 'Aclamadas por la critica',
      onNextPage: () => moviesProvider.getTopRatedMovies(),
    );
  }
}
