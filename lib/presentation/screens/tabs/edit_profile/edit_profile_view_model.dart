import 'package:bloc/bloc.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/presentation/screens/tabs/edit_profile/edit_profile_contract.dart';

class EditProfileViewModel extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileViewModel()
      : super(EditProfileState(selectedAvatar: AppAsset.avatar1)) {
    on<AvatarChangedEvent>(_onAvatarChanged);
  }

  void _onAvatarChanged(AvatarChangedEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(selectedAvatar: event.newAvatarPath));
  }
}
