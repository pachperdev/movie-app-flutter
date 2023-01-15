import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                _PosterAndTitle(movie: movie),
                const SizedBox(height: 10),
                _Overview(movie: movie),
                const SizedBox(height: 10),
                RepartoSlider(movieId: movie.id, title: 'Reparto Principal'),
                const SizedBox(height: 5),
                MovieSliderSuggestionDetails(
                    movies: moviesProvider.recommendMovies,
                    future: moviesProvider.getRecommendMovies(movie.id),
                    title: 'Peliculas recomendadas'),
                const SizedBox(height: 10),
                MovieSliderSuggestionDetails(
                    movies: moviesProvider.recommendMovies,
                    future: moviesProvider.getSimilarMovies(movie.id),
                    title: 'Peliculas similares'),
                const SizedBox(height: 230),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: InkWell(
        child: const Icon(Icons.arrow_back_ios_new_outlined),
        onTap: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black38,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: const AssetImage('lib/assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              width: 110,
              height: 155,
              fit: BoxFit.cover,
              placeholder: const AssetImage('lib/assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
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
                  maxLines: 2,
                ),
                const SizedBox(height: 3),
                Opacity(
                  opacity: 0.8,
                  child: Text(
                    'Fecha de estreno: ${movie.releaseDate!}',
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      color: Colors.amberAccent,
                    ),
                    const SizedBox(width: 5),
                    Text('${movie.voteAverage}')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(textAlign: TextAlign.justify, movie.overview),
    );
  }
}
