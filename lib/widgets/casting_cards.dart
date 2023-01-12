import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 200,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 155,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
                width: 110,
                height: 155,
                fit: BoxFit.cover,
                placeholder: const AssetImage('lib/assets/no-image.jpg'),
                image: NetworkImage(actor.fullProfilePath)),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
