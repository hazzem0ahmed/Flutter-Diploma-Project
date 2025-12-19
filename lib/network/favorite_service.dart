import 'dart:convert';
import 'package:http/http.dart' as http;

import '../features/data/movies_details/movies_details_data.dart';

class FavoriteService {
  static const String baseUrl =
      'https://movie-api-rho.vercel.app/api/v1';

  static Future<List<Movie>> getFavorites() async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites'),
    );

    final data = jsonDecode(response.body);
    return List<Movie>.from(
      data['data'].map((e) => Movie.fromJson(e)),
    );
  }

  static Future<void> toggleFavorite(String movieId) async {
    await http.post(
      Uri.parse('$baseUrl/favorites'),
      body: {'movieId': movieId},
    );
  }
}

