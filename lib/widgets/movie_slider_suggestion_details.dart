import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSliderSuggestionDetails extends StatelessWidget {
  final int movieId;
  final String? title;
  final List<Movie> movies;

  const MovieSliderSuggestionDetails(
      {Key? key, required this.movieId, this.title, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getRecommendMovies(movieId),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 220,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Movie> movie = snapshot.data!;

        return SizedBox(
          // margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 220,
          // color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: movie.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) => _CastCard(movie[index]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Movie movie;
  const _CastCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 155,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                  width: 110,
                  height: 155,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('lib/assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg)),
            ),
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
