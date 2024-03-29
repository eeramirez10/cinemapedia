import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/share/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _HomeView(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: "Categorias"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Favoritos"),

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

  
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlide = ref.watch(moviesSlidesShowProvider);
  
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: moviesSlide),
        
        MovieHorizontalListView(
          movies: nowPlayingMovies,
          title: 'En Cines',
          subTitle: 'Lunes 20',
          loadNextPage: () async {

            await ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
          },
        ),
        

      ],
    );
  }
}
