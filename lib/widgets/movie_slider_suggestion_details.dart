import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';

class MovieSliderSuggestionDetails extends StatelessWidget {
  final String? title;
  final Future<List<Movie>>? future;

  const MovieSliderSuggestionDetails({
    Key? key,
    this.title,
    required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 220,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Movie> movie = snapshot.data!;
        if (movie.isNotEmpty) {
          return SizedBox(
            // margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 245,
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
        }
        return const SizedBox();
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
