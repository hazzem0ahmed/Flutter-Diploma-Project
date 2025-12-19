import 'package:bloc/bloc.dart';
import 'package:movies/presentation/screens/details_screen/details_screen_contract.dart';

class HomeTabViewModel extends Bloc<DetailsScreenAction, DetailsScreenState> {
  HomeTabViewModel() : super(DetailsScreenState()) {
    on<GoToDetailsScreenAction>(_goToDetailScreen);
  }

  void _goToDetailScreen(
    GoToDetailsScreenAction action,
    Emitter<DetailsScreenState> emitter,
  ) {
    emitter(state.copyWith(navigation: NavigateToDetailsScreen(action.movie)));
  }
}
