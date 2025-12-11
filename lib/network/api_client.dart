import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/data/movies_details/movies_details_data.dart';
import 'package:retrofit/retrofit.dart';

import '../auth/data/models/auth_response_dto.dart';
import '../auth/data/models/register_request_dto.dart';
import '../features/data/moviesList/movies_list_data.dart';
import 'models/sugg_movie_api.dart';

part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET("/api/v2/list_movies.json")
  Future<MoviesListData> getMoviesList({
    @Query("sort_by") String sortBy = "rating",
    @Query("movie_id") int? movieId,
  });

  @GET("/api/v2/movie_details.json")
  Future<MoviesDetailsData> getMoviesDetails({
    @Query("movie_id") int? movieId,
    @Query("with_images") bool withImages = true,
    @Query("with_cast") bool withCast = true,
  });

  @GET("/api/v2/movie_suggestions.json")
  Future<SuggMovieApi> getSuggestedMovies({
    @Query("movie_id") required int movieId,
  });

  @POST("/api/v1/auth/signup")
  Future<AuthResponseDto> signUp(@Body() RegisterRequestDto request);
}
