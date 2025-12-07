import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/core/padding_extension.dart';
import 'package:movies/core/text_theme.dart';
import 'package:movies/features/data/moviesList/movies_list_data.dart';
import 'package:movies/presentation/widgets/cast%20card/cast_card.dart';
import 'package:movies/presentation/widgets/movie_crauosal_card.dart';
import 'package:movies/presentation/widgets/movie_details/movie_details.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movies;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(backgroundColor: AppColors.black),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: context.spaceHeight * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.largeCoverImage??""),
                    fit: BoxFit.cover,
                    onError: (_, _) => const Icon(Icons.error),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppAsset.videoIcon),
                  Text(
                   movie.titleLong??"",
                    style: context.text.titleLarge!.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ).withPaddingAll(8),
                ],
              ),
            ],
          ),
          SizedBox(height: context.spaceHeight * 0.06),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              fixedSize: Size(double.infinity, context.spaceHeight * 0.06),
            ),
            onPressed: () {
              //todo
            },
            child: Text(
              context.locale.watch,
              style: AppTextTheme().homeTextTheme(AppColors.white, 20),
            ),
          ).withPaddingAll(8),
          SizedBox(height: context.spaceHeight * 0.06),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MovieDetailsDesign("N/A", Icons.favorite),
              MovieDetailsDesign(movie.runtime?.toString()??"N/A", Icons.watch_later),
              MovieDetailsDesign(movie.rating?.toString()??"N/A", Icons.star),
            ],
          ),
          SizedBox(height: context.spaceHeight * 0.06),
          Text(
            context.locale.screenShots,
            style: context.text.titleLarge!.copyWith(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ).withPaddingAll(8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image.asset("assets/images/test1.jpg"),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image.asset("assets/images/test1.jpg"),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image.asset("assets/images/test1.jpg"),
          ),
          SizedBox(height: context.spaceHeight * 0.03),
          Text(
            context.locale.similarMovies,
            style: context.text.titleLarge!.copyWith(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ).withPaddingAll(8),
          //todo here isMovie Suggestions from movie suggestions details api
          // GridView.builder(
          //   padding: context.withPadding(8),
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: 4,
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 5,
          //     mainAxisSpacing: 5,
          //     childAspectRatio: 189 / 279,
          //   ),
          //   itemBuilder: (context, index) => MovieCarouselCard(),
          // ),
          SizedBox(height: context.spaceHeight * 0.03),
          Text(
            context.locale.summary,
            style: context.text.titleLarge!.copyWith(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ).withPaddingAll(8),
          SizedBox(height: context.spaceHeight * 0.01),
          Text(
            movie.descriptionFull??"",
            style: context.text.bodyMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: context.spaceHeight * 0.03),
          Text(
            context.locale.cast,
            style: context.text.titleLarge!.copyWith(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ).withPaddingAll(8),
          SizedBox(height: context.spaceHeight * 0.03),
          Column(
              children: [CastCard(), CastCard(), CastCard()]),
          SizedBox(height: context.spaceHeight * 0.03),
          Text(
            context.locale.genres,
            style: context.text.titleLarge!.copyWith(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ).withPaddingAll(8),
          SizedBox(height: context.spaceHeight * 0.01),
          GridView.builder(
            padding: context.withPadding(8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movie.genres?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              childAspectRatio: 2.9,
            ),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: const Color(0xFF282A28),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  movie.genres![index],
                  style: context.text.titleMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
