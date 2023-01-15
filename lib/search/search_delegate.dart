import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
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
    if (query.isEmpty) {
      return MovieSliderBuildSuggestions(
        movies: moviesProvider.topRatedMovies,
        title: 'Aclamadas por la critica',
        onNextPage: () => moviesProvider.getTopRatedMovies(),
      );
    }
    return FutureBuilder(
      future: moviesProvider.getSearchMovies(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }
        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              // color: Colors.greenAccent,
              child: Text(
                'Principales resultados: $query',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 5),
                physics: const BouncingScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (context, index) => _MovieItem(movies[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';

    return Container(
      width: double.infinity,
      height: 110,
      color: Colors.grey.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: FadeInImage(
                width: 150,
                height: 110,
                fit: BoxFit.cover,
                placeholder: const AssetImage('lib/assets/no-image.jpg'),
                image: NetworkImage(movie.fullBackdropPath),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    movie.originalTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 3),
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      movie.releaseDate ?? '',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
