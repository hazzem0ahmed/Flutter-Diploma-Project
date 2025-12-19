import '../../../../features/data/moviesList/movies_list_data.dart';

abstract class ExploreStates {}

class ExploreInitial extends ExploreStates {}

class ExploreLoading extends ExploreStates {}

class ExploreSuccess extends ExploreStates {
  final List<Movies> movies;
  final Set<String> genres;
  final String selectedGenre;

  ExploreSuccess({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}

class ExploreError extends ExploreStates {
  final String message;

  ExploreError(this.message);
}
