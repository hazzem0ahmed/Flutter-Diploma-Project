import 'package:flutter/material.dart';
import 'package:movies/core/app_extensions.dart';
import '../../../core/app_asset.dart';
import '../../../core/app_colors.dart';

class CastCard extends StatelessWidget {
  const CastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.spaceHeight * 0.1,
      child: Card(
        color: Colors.grey[850],
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  AppAsset.onBoarding1Image,
                  width: 70,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name: Hayley Atwell",
                    style: context.text.titleLarge!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Character: Captain Carter",
                    style: context.text.titleLarge!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
