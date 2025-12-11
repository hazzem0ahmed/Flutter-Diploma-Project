import 'package:flutter/material.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/core/padding_extension.dart';
import 'package:movies/core/text_theme.dart';
import 'package:movies/features/data/moviesList/movies_list_data.dart';
import 'package:movies/network/api_client.dart';
import 'package:movies/network/dio_provider.dart';
import 'package:movies/presentation/widgets/movie_details/movie_details.dart';
import '../../../features/data/movies_details/movies_details_data.dart'
    as details_data;
import '../../../network/models/sugg_movie_api.dart';
import '../../widgets/movie_suggestion_card.dart';
import '../../widgets/watch_handler_button/watch_handler_button.dart';

Future<details_data.Movie?> fetchMovieDetails(String id) async {
  final response = await ApiClient(
    dioProvider(),
  ).getMoviesDetails(movieId: int.parse(id));
  return response.data?.movie;
}

Future<List<SuggestionMovies>> fetchSuggestedMovies(String id) async {
  final response = await ApiClient(
    dioProvider(),
  ).getSuggestedMovies(movieId: int.parse(id));
  final moviesList = response.data?.movies;

  if (moviesList == null) return [];
  return moviesList.map((e) => e).toList();
}

class DetailsScreen extends StatefulWidget {
  static const String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  void onWatchPressed(BuildContext context, Movies movie) {
    if (movie.ytTrailerCode != null && movie.ytTrailerCode!.isNotEmpty) {
      final youtubeUrl =
          "https://www.youtube.com/watch?v=${movie.ytTrailerCode}";
      WatchHandler.watch(context, youtubeUrl);
    } else {
      WatchHandler.watch(context, movie.torrents![0].url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movies;

    return FutureBuilder<details_data.Movie?>(
      future: fetchMovieDetails(movie.id.toString()),
      builder: (context, snapshot) {

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, size: 50),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  //todo
                },
                child: Icon(
                  Icons.bookmark_outlined,
                  size: 50,
                ).withPaddingAll(8),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: context.spaceHeight * 0.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie.largeCoverImage ?? ""),
                        fit: BoxFit.cover,
                        onError: (_, _) => const Icon(Icons.error),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.black.withAlpha(90),
                            AppColors.black.withAlpha(200),
                          ],
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
                        movie.titleLong ?? "",
                        style: context.text.titleLarge!.copyWith(
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ).withPaddingAll(8),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.spaceHeight * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  fixedSize: Size(double.infinity, context.spaceHeight * 0.06),
                ),
                onPressed: () {
                  onWatchPressed(context, movie);
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
                  MovieDetailsDesign(
                    snapshot.data?.likeCount.toString() ?? "N/A",
                    Icons.favorite,
                  ),
                  MovieDetailsDesign(
                    movie.runtime?.toString() ?? "N/A",
                    Icons.watch_later,
                  ),
                  MovieDetailsDesign(
                    movie.rating?.toString() ?? "N/A",
                    Icons.star,
                  ),
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
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      snapshot.data?.mediumScreenshotImage1 ?? "",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, load) {
                        if (load == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      snapshot.data?.mediumScreenshotImage2 ?? "",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, load) {
                        if (load == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      snapshot.data?.mediumScreenshotImage3 ?? "",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, load) {
                        if (load == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
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
              FutureBuilder<List<SuggestionMovies>>(
                future: fetchSuggestedMovies(movie.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Error Loading Suggestions",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final suggestions = snapshot.data ?? [];

                  if (suggestions.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "No Similar Movies Found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: context.withPadding(8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: suggestions.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 189 / 279,
                        ),
                    itemBuilder: (context, index) =>
                        MovieSuggestionCard(suggMovie: suggestions[index]),
                  );
                },
              ),

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
                movie.summary ?? snapshot.data?.descriptionFull ?? "",
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
              ).withHorizontalPadding(8),
              SizedBox(
                height: context.spaceHeight * 0.4,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final cast = snapshot.data!.cast![index];
                    return Card(
                      color: Colors.grey[850],
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          spacing: 10,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                cast.urlSmallImage ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: context.spaceWidth * 0.01),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cast.name ?? "",
                                    style: context.text.titleLarge!.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(height: context.spaceHeight * 0.01),
                                  Text(
                                    cast.characterName ?? "",
                                    style: context.text.titleLarge!.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, _) =>
                      SizedBox(height: context.spaceHeight * 0.02),
                  itemCount: snapshot.data?.cast?.length ?? 0,
                ),
              ),
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
      },
    );
  }
}
