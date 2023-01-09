import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const _CastCard(),
            ),
          )
        ],
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({
    Key? key,
  }) : super(key: key);

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
            child: const FadeInImage(
              width: 110,
              height: 155,
              fit: BoxFit.cover,
              placeholder: AssetImage('lib/assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/300x400'),
            ),
          ),
          const Text(
            'Insertar titulo de la pelucula aqui: la pelicula',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
