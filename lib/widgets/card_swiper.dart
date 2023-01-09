import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie?>? movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        physics: const BouncingScrollPhysics(),
        itemCount: movies!.length,
        viewportFraction: 0.75,
        scale: 0.8,
        layout: SwiperLayout.DEFAULT,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies![index];
          // ignore: avoid_print
          print(movie!.fullPosterImg);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'arguments-car-swiper'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('lib/assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
              ),
            ),
          );
        },
      ),
    );
  }
}
