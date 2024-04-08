import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDatasource extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieApiKey,
    'language': 'es-MX',
  }));

  @override
  Future<List<Actor>> getActorsByMovie({required String movieId}) async {
    final response = await dio.get('/movie/$movieId/credits');

    final result = CreditsResponse.fromJson(response.data);

    return result.cast.map((e) => ActorMapper.actorDBToEntity(e)).toList();
  }
}
