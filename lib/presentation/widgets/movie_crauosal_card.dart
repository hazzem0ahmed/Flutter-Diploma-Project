import 'package:flutter/material.dart';

import '../../core/app_asset.dart';
import '../../core/app_colors.dart';
import '../../core/app_extensions.dart';
import '../../core/padding_extension.dart';

class MovieCarouselCard extends StatelessWidget {
  const MovieCarouselCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(AppAsset.onBoarding5Image),
            ),
          ),
        ),
        Container(
          padding: context.withPadding(3),
          decoration: BoxDecoration(color: AppColors.black.withAlpha(250),
            borderRadius: BorderRadius.circular(10),),
          width: context.spaceWidth * 0.12,
          height: context.spaceHeight * 0.035,
          child: Row(
            children: [
              Text(
                "7.7",
                style: context.text.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                ),
              ),
              Icon(Icons.star, color: Colors.yellow),
            ],
          ),
        ).withPaddingAll(9),
      ],
    );
  }
}
