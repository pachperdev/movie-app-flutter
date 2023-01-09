import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: 10,
        viewportFraction: 0.75,
        scale: 0.8,
        layout: SwiperLayout.DEFAULT,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'arguments-car-swiper'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('lib/assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/300x400'),
              ),
            ),
          );
        },
      ),
    );
  }
}
