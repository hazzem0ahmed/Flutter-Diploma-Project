import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/app_asset.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_extensions.dart';
import 'package:movies/presentation/screens/details_screen/details_screen.dart';
import 'package:movies/presentation/screens/tabs/homeTab/home_tab_view_model.dart';
import 'package:movies/presentation/screens/tabs/homeTab/hometab_contract.dart';
import 'package:movies/presentation/widgets/movie%20card/movie_card.dart';
import '../../../../core/text_theme.dart';
import '../../../widgets/movie_crauosal_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeTabViewModel viewModel = HomeTabViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.add(GetMoviesAction());
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeTabViewModel, HomeTabState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state.navigation is NavigateToDetailsScreen) {
          Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: (state.navigation as NavigateToDetailsScreen).movie,
          );
        }
      },
      child: BlocBuilder<HomeTabViewModel, HomeTabState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state.moviesLoading && state.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessages != null && state.errorMessages!.isNotEmpty) {
            return Center(
              child: Text(
                state.errorMessages!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
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
                        colors: [
                          AppColors.black,
                          AppColors.black.withAlpha(50),
                        ],
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
                        CarouselSlider.builder(
                          itemCount: state.movies.length,
                          options: CarouselOptions(
                            height: context.spaceHeight * 0.4,
                            viewportFraction: 0.6,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            return GestureDetector(
                              onTap: () {
                                viewModel.add(
                                  GoToDetailsScreenAction(state.movies[index]),
                                );
                              },
                              child: MovieCarouselCard(
                                movie: state.movies[index],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: context.spaceHeight * 0.02),
                        Image.asset(AppAsset.watchNow),
                        ListTile(
                          leading: Text(
                            context.locale.action,
                            style: AppTextTheme().homeTextTheme(
                              AppColors.white,
                              16,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.locale.seeMore,
                                style: AppTextTheme().homeTextTheme(
                                  AppColors.yellow,
                                  20,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.yellow,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.spaceHeight * 0.3,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (_, _) =>
                                SizedBox(width: context.spaceWidth * 0.1),
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                viewModel.add(
                                  GoToDetailsScreenAction(state.movies[index]),
                                );
                              },
                              child: MovieCard(movie: state.movies[index]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
