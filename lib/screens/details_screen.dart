import 'package:flutter/material.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                const _PosterAndTitle(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const CastingCards()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
          color: Colors.black12,
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: const Text(
            'movie.title',
            style: TextStyle(fontSize: 18),
          ),
        ),
        background: const FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('lib/assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x200'),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const FadeInImage(
              width: 110,
              height: 155,
              fit: BoxFit.cover,
              placeholder: AssetImage('lib/assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/300x400'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Movie-title',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
                maxLines: 2,
              ),
              const Text(
                'Movie-original-title',
                maxLines: 1,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.star_border_outlined,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(width: 5),
                  Text('Movie-voteAverage')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Text(
          textAlign: TextAlign.justify,
          'Aliqua culpa cillum ullamco occaecat sunt officia laborum velit in elit quis minim. Sit magna nulla exercitation duis consequat aliqua cupidatat ut dolore commodo aliqua Lorem cupidatat eu. Sint cillum ex aliqua sunt. In anim incididunt laborum pariatur elit ullamco nulla proident elit tempor tempor anim duis. Amet occaecat cillum sit sit commodo laborum.'),
    );
  }
}
