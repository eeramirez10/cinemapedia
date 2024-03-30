import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';

class PopularMovies extends StatelessWidget {
  final List<Movie> popularMovies;
  final VoidCallback loadNextPage;
  const PopularMovies({super.key, required this.popularMovies, required this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListView(
      movies: popularMovies,
      title: 'Peliculas populares',
      subTitle: 'Lunes 20',
      loadNextPage: loadNextPage
    );
  }
}
