import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/api_client.dart';
import '../../details_screen/details_screen.dart';
import 'api_manager.dart';
import 'api_manager.dart' as ApiManager;
import 'explore_cubit.dart';
import 'explore_state.dart';

class ExploreTab extends StatelessWidget {
  static const String routeName = "Explore";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExploreCubit(ApiClient(ApiManager.dio))..getExploreMovies(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 15, bottom: 10),
              child: Text(
                "Browse Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            BlocBuilder<ExploreCubit, ExploreStates>(
              buildWhen: (previous, current) => current is ExploreSuccess,
              builder: (context, state) {
                if (state is ExploreSuccess) {
                  return SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: state.genres.length,
                      itemBuilder: (context, index) {
                        String genreName = state.genres.elementAt(index);
                        bool isSelected = state.selectedGenre == genreName;

                        return GestureDetector(
                          onTap: () {
                            context.read<ExploreCubit>().filterMovies(
                              genreName,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.amber
                                  : Colors.transparent,
                              border: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              genreName,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox(height: 45);
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<ExploreCubit, ExploreStates>(
                builder: (context, state) {
                  if (state is ExploreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  } else if (state is ExploreSuccess) {
                    if (state.movies.isEmpty) {
                      return const Center(child: Text("No movies found", style: TextStyle(color: Colors.white)));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        var movie = state.movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: movie.id,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              movie.mediumCoverImage ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[900],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                    ),
                                  ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ExploreError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
