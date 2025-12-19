import 'package:bloc/bloc.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tab_contract.dart';

class ProfileTabViewModel extends Bloc<ProfileTabAction, ProfileTabState> {
  ProfileTabViewModel() : super(ProfileTabState()) {
    on<ChangeTabBarAction>((event, emit) {
      emit(state.copyWith(selectedIndex: event.newIndex));
    });
  }
}
