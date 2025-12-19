import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/api_client.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreStates> {
  final ApiClient _apiClient;

  ExploreCubit(this._apiClient) : super(ExploreInitial());

  Set<String> _cachedGenres = {"All"};

  void getExploreMovies() async {
    emit(ExploreLoading());
    try {
      final response = await _apiClient.getMoviesList();
      final movies = response.data?.movies ?? [];

      for (var movie in movies) {
        if (movie.genres != null) {
          _cachedGenres.addAll(movie.genres!);
        }
      }
      emit(
        ExploreSuccess(
          movies: movies,
          genres: _cachedGenres,
          selectedGenre: "All",
        ),
      );
    } catch (e, stacktrace) {
      print("Error Source: $e");
      print("Stacktrace: $stacktrace");
      emit(ExploreError(e.toString()));
    }
  }

  void filterMovies(String genre) async {
    final currentState = state;
    if (currentState is ExploreSuccess) {
      final currentGenres = currentState.genres;

      emit(ExploreLoading());
      try {
        String? genreToSend = (genre == "All") ? null : genre;

        final response = await _apiClient.getMoviesList(genre: genreToSend);
        final movies = response.data?.movies ?? [];

        emit(
          ExploreSuccess(
            movies: movies,
            genres: currentGenres,
            selectedGenre: genre,
          ),
        );
      } catch (e) {
        emit(ExploreError("Check your internet connection or use VPN"));
      }
    }
  }
}
