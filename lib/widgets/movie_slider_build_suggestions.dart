// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class MovieSliderBuildSuggestions extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSliderBuildSuggestions(
      {Key? key,
      required this.movies,
      required this.title,
      required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSliderBuildSuggestions> createState() =>
      _MovieSliderBuildSuggestionsState();
}

class _MovieSliderBuildSuggestionsState
    extends State<MovieSliderBuildSuggestions> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // print(
      // 'sc.p.p: ${scrollController.position.pixels}, sc.p.max: ${scrollController.position.maxScrollExtent}');
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            // color: Colors.greenAccent,
            child: Text(
              widget.title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) =>
                _MoviePoster(movie: widget.movies[index]),
          ),
        ),
      ],
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 145,
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
                height: 145,
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
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border_outlined,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox(width: 5),
                      Text('${movie.voteAverage}')
                    ],
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
