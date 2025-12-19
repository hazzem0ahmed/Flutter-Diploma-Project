import '../../../../features/data/moviesList/movies_list_data.dart';

class HomeTabState {
  List<Movies> movies;
  String? errorMessages;
  bool moviesLoading;
  HomeTabNavigation? navigation;

  HomeTabState({
    this.movies = const [],
    this.moviesLoading = false,
    this.errorMessages,
    this.navigation,
  });

  HomeTabState copyWith({
    List<Movies>? movies,
    bool? moviesLoading,
    String? errorMessages,
    HomeTabNavigation? navigation,
  }) {
    return HomeTabState(
      movies: movies ?? this.movies,
      moviesLoading: moviesLoading ?? this.moviesLoading,
      errorMessages: errorMessages ?? this.errorMessages,
      navigation: navigation,
    );
  }
}

sealed class HomeTabAction {}

class GetMoviesAction extends HomeTabAction {
  final int? movieId;

  GetMoviesAction({this.movieId});
}

class GoToDetailsScreenAction extends HomeTabAction {
  final Movies movie;

  GoToDetailsScreenAction(this.movie);
}

sealed class HomeTabNavigation {}

class NavigateToDetailsScreen extends HomeTabNavigation {
  final Movies movie;

  NavigateToDetailsScreen(this.movie);
}
