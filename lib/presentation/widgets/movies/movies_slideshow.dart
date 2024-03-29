import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 210,
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          itemCount: movies.length,
          autoplay: true,
          indicatorLayout: PageIndicatorLayout.COLOR,
          pagination: const SwiperPagination(),
         
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _Slide(movie: movie);
          },
        ));
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Image.network(
        "https://image.tmdb.org/t/p/w500/${movie.backdropPath}");
  }
}
