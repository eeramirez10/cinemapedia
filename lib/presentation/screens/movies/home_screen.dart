import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';

import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/movies/now_playing_movies.dart';
import 'package:cinemapedia/presentation/widgets/movies/pupular_movies.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/share/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _HomeView(),
      bottomNavigationBar: BottomNavigationBar(elevation: 0, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: "Categorias"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: "Favoritos"),
      ]),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlide = ref.watch(moviesSlidesShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    // return FullScreenLoader();
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlide),
                const NowPlayingMovies(),
                PopularMovies(
                    popularMovies: popularMovies,
                    loadNextPage: () async {
                      await ref
                          .read(popularMoviesProvider.notifier)
                          .loadNextPage();
                    }),
                MovieHorizontalListView(
                  movies: upcomingMovies,
                  title: 'Proximamente',
                  subTitle: 'Lunes 20',
                  loadNextPage: () async {
                    await ref
                        .read(upcomingMoviesProvider.notifier)
                        .loadNextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Populares',
                  subTitle: 'Lunes 20',
                  loadNextPage: () async {
                    await ref
                        .read(topRatedMoviesProvider.notifier)
                        .loadNextPage();
                  },
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          },
        ))
      ],
    );
  }
}
