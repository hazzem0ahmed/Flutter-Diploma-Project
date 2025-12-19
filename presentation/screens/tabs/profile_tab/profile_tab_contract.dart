class ProfileTabState {
  final int selectedIndex;

  ProfileTabState({this.selectedIndex = 0});

  ProfileTabState copyWith({int? selectedIndex}) {
    return ProfileTabState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}

sealed class ProfileTabAction {}

class ChangeTabBarAction extends ProfileTabAction {
  final int newIndex;

  ChangeTabBarAction(this.newIndex);
}
