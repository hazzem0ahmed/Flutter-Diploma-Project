import 'package:movies/core/app_asset.dart';

class AvatarData {
  final String imagePath;
  final int id;

  AvatarData(this.imagePath, this.id);
}

List<AvatarData> avatarList = [
  AvatarData(AppAsset.avatar1, 1),
  AvatarData(AppAsset.avatar2, 2),
  AvatarData(AppAsset.avatar3, 3),
  AvatarData(AppAsset.avatar4, 4),
  AvatarData(AppAsset.avatar5, 5),
  AvatarData(AppAsset.avatar6, 6),
  AvatarData(AppAsset.avatar7, 7),
  AvatarData(AppAsset.avatar8, 8),
  AvatarData(AppAsset.avatar9, 9),
];
