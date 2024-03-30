import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingMovies extends ConsumerStatefulWidget {
  const NowPlayingMovies({super.key});

  @override
  NowPlayingMoviesState createState() => NowPlayingMoviesState();
}

class NowPlayingMoviesState extends ConsumerState<NowPlayingMovies> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    return MovieHorizontalListView(
      movies: nowPlayingMovies,
      title: 'En Cines',
      subTitle: 'Lunes 20',
      loadNextPage: () async {
        await ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
      },
    );
  }
}
