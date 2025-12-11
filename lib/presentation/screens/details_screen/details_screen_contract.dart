import '../../../../features/data/moviesList/movies_list_data.dart';

class DetailsScreenState {
  List<Movies> movies;
  String? errorMessages;
  bool moviesLoading;
  DetailsScreenNavigation? navigation;

  DetailsScreenState({
    this.movies = const [],
    this.moviesLoading = false,
    this.errorMessages,
    this.navigation,
  });

  DetailsScreenState copyWith({
    List<Movies>? movies,
    bool? moviesLoading,
    String? errorMessages,
    DetailsScreenNavigation? navigation,
  }) {
    return DetailsScreenState(
      movies: movies ?? this.movies,
      moviesLoading: moviesLoading ?? this.moviesLoading,
      errorMessages: errorMessages ?? this.errorMessages,
      navigation: navigation,
    );
  }
}

sealed class DetailsScreenAction {}

class GetMoviesAction extends DetailsScreenAction {
  final int? movieId;
  GetMoviesAction({this.movieId});
}

class GoToDetailsScreenAction extends DetailsScreenAction {
  final Movies movie;
  GoToDetailsScreenAction(this.movie);
}

sealed class DetailsScreenNavigation {}

class NavigateToDetailsScreen extends DetailsScreenNavigation {
  final Movies movie;
  NavigateToDetailsScreen(this.movie);
}