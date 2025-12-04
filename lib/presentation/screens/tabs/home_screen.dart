import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/presentation/widgets/movie%20card/movie_card.dart';

import '../../../core/text_theme.dart';
import '../../widgets/movie_crauosal_card.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "/homeTab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.onBoarding5Image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.black, AppColors.black.withAlpha(50)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: context.spaceHeight * 0.04),
                  Image.asset(AppAsset.availableNow),
                  SizedBox(height: context.spaceHeight * 0.02),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: context.spaceHeight * 0.4,
                      viewportFraction: 0.6,
                      enlargeCenterPage: true,
                    ),
                    items: List.generate(15, (index) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              //todo
                            },
                            child: MovieCarouselCard(),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: context.spaceHeight * 0.02),
                  Image.asset(AppAsset.watchNow),
                  ListTile(
                    leading: Text(
                      context.locale.action,
                      style: AppTextTheme().homeTextTheme(AppColors.white, 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //todo
                          },
                          child: Text(
                            context.locale.seeMore,
                            style: AppTextTheme().homeTextTheme(
                              AppColors.yellow,
                              20,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: AppColors.yellow),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.spaceHeight * 0.3,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, _) =>
                          SizedBox(width: context.spaceWidth * 0.1),
                      itemCount: 16,
                      itemBuilder: (context, index) => MovieCard(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
