import 'package:bloc/bloc.dart';
import 'package:movies/network/api_client.dart';
import 'package:movies/network/dio_provider.dart';
import 'package:movies/presentation/screens/tabs/homeTab/hometab_contract.dart';

class HomeTabViewModel extends Bloc<HomeTabAction, HomeTabState> {

  final ApiClient _apiClient = ApiClient(dioProvider());

  HomeTabViewModel() :super(HomeTabState()) {
    on<GetMoviesAction>(_loadMovies);
    on<GoToDetailsScreenAction>(_goToDetailScreen);
  }


  Future<void> _loadMovies(GetMoviesAction action, Emitter<HomeTabState> emitter) async {
    emitter(state.copyWith(moviesLoading: true, errorMessages: ""));
    try {
      var response = await _apiClient.getMoviesList(movieId: action.movieId);
      emitter(state.copyWith(
        movies: response.data?.movies ?? [],
        moviesLoading: false,
      ));
    }
    catch (e) {
      emitter(state.copyWith(
        errorMessages: e.toString(),
        moviesLoading: false,
      ));
    }
  }

  void _goToDetailScreen(GoToDetailsScreenAction action, Emitter<HomeTabState> emitter) {
    emitter(state.copyWith(navigation: NavigateToDetailsScreen(action.movie)));
  }


}
