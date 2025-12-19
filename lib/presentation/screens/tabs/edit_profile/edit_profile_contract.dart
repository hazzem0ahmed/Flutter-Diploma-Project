sealed class EditProfileEvent {}

class AvatarChangedEvent extends EditProfileEvent {
  final String newAvatarPath;

  AvatarChangedEvent(this.newAvatarPath);
}

class EditProfileState {
  final String selectedAvatar;

  EditProfileState({required this.selectedAvatar});

  EditProfileState copyWith({
    String? selectedAvatar,
  }) {
    return EditProfileState(
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
    );
  }
}