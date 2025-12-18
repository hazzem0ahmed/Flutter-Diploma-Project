import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/screens/tabs/profile_tab/profile_tabs_content/history_tab/History_Cubit.dart';
import '../../../../../../features/data/movies_details/movies_details_data.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key, required List<Map<String, dynamic>> historyMovies});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, List<MoviesDetailsData>>(
      builder: (context, history) {
        return GridView.builder(
            itemCount: history.length,
            itemBuilder: (_, index) {
              final movie = history[index].data?.movie;

              return Column(
                children: [
                  Image.network(
                    movie?.largeCoverImage ?? 'https://via.placeholder.com/150',
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ],
              );

            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,

              childAspectRatio: 0.63,
            )
        );

      },
    );

  }
}