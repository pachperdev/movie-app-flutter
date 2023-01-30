import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/search/search_delegate.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // ignore: avoid_print
    // print(moviesProvider.popularMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peliculas en Cines',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            const SizedBox(height: 5),
            MovieSlider(
              movies: moviesProvider.upcomingMovies,
              title: 'Próximamente en Cines',
              onNextPage: () => moviesProvider.getUpcomingMovies(),
            ),
            const SizedBox(height: 5),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Peliculas Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
            const SizedBox(height: 5),
            MovieSlider(
              movies: moviesProvider.topRatedMovies,
              title: 'Peliculas Mejor Valoradas',
              onNextPage: () => moviesProvider.getTopRatedMovies(),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
