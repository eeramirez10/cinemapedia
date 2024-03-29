import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListView extends StatelessWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  
  const MovieHorizontalListView({super.key, required this.movies, this.title, this.subTitle, this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(title != null || subTitle != null)
          _Title(title: title, subTitle: subTitle,),

          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                final movie = movies[index];

                return _Slide(movie: movie);
              },
            )
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({ required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageSlide(movie: movie),
          const SizedBox(height: 5,),
          SizedBox(
            width: 150,
            child: Center(child: Text(movie.title, maxLines: 2, style: textStyle.titleSmall,)),
            
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.amber.shade800,),
                const SizedBox(width: 5,),
                Text(
                  movie.voteAverage.toString().substring(0,3), 
                  style: textStyle.bodyMedium?.copyWith(
                    color:  Colors.amber.shade800 
                  ), 
                ),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ImageSlide extends StatelessWidget {
  const _ImageSlide({
   
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.posterPath,
          fit: BoxFit.cover, 
          width: 150,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress != null){
             return const Padding(
              padding: EdgeInsets.only(top:75),
               child: Center(
                 child: CircularProgressIndicator( strokeWidth: 2,),
               ),
             );
            }
            return FadeIn(child: child);
          },
        ), 
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top:10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(title!,style: titleStyle,),
          const Spacer(),
          FilledButton.tonal(
            onPressed:(){}, 
            style: const ButtonStyle( visualDensity: VisualDensity.compact), 
            child: Text(subTitle!),
          )
        ],
      ),
    );
  }
}