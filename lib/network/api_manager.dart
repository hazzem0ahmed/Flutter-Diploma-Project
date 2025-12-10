import 'package:dio/dio.dart';
import 'package:movies/network/models/sugg_movie_api.dart';

class APIManager {
 final Dio _dio = Dio();
 final String baseUrl = "https://yts.lt";

 Future<SuggMovieApi> getSuggestedMovies(String movieId) async {
  try {
   final response = await _dio.get(
    "$baseUrl/api/v2/movie_suggestions.json",
    queryParameters: {
     "movie_id": movieId,
    },
   );

   return SuggMovieApi.fromJson(response.data);
  } catch (e) {
   throw Exception("Failed to load suggestions: $e");
  }
 }
}
