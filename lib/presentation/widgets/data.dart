import 'package:movies/core/app_asset.dart';

class AvatarData {
  final String imagePath;
  final int id;

  AvatarData(this.imagePath, this.id);
}

List<AvatarData> avatarList = [
  AvatarData(AppAsset.gamerImage1, 1),
  AvatarData(AppAsset.gamerImage1, 2),
  AvatarData(AppAsset.gamerImage1, 3),
  AvatarData(AppAsset.gamerImage1, 4),
  AvatarData(AppAsset.gamerImage1, 5),
  AvatarData(AppAsset.gamerImage1, 6),
  AvatarData(AppAsset.gamerImage1, 7),
  AvatarData(AppAsset.gamerImage1, 8),
  AvatarData(AppAsset.gamerImage1, 9),
];
