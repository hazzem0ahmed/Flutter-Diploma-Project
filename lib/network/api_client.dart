import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../auth/data/models/auth_response_dto.dart';
import '../auth/data/models/register_request_dto.dart';
import '../features/data/moviesList/movies_list_data.dart';

part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/api/v2/list_movies.json")
  Future<MoviesListData> getMoviesList(
      {@Query("sort_by") String sortBy = "rating",
        @Query("movie_id") int? movieId});

  @POST("/api/v1/auth/signup")
  Future<AuthResponseDto> signUp(@Body() RegisterRequestDto request);



}
