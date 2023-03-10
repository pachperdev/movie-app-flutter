import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class RepartoSlider extends StatelessWidget {
  final int movieId;
  final String? title;
  const RepartoSlider({Key? key, required this.movieId, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 220,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;
        if (cast.isNotEmpty) {
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
                    itemCount: cast.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) => _CastCard(cast[index]),
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
  final Cast cast;
  const _CastCard(this.cast);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 155,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Center(child: Text(cast.name)),
                    content: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              width: 250,
                              height: 350,
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('lib/assets/no-image.jpg'),
                              image: NetworkImage(cast.fullProfilePath),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              const Text('Popularidad: '),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_border_outlined,
                                    color: Colors.amberAccent,
                                  ),
                                  const SizedBox(width: 3),
                                  Text('${cast.popularity} %'),
                                  const SizedBox(width: 3),
                                  const Icon(
                                    Icons.star_border_outlined,
                                    color: Colors.amberAccent,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                  width: 110,
                  height: 155,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('lib/assets/no-image.jpg'),
                  image: NetworkImage(cast.fullProfilePath)),
            ),
          ),
          Text(
            cast.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
