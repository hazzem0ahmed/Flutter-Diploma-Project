import 'package:flutter/material.dart';
import 'package:movies/network/models/sugg_movie_api.dart';
import '../../core/app_colors.dart';
import '../../core/app_extensions.dart';
import '../../features/data/moviesList/movies_list_data.dart';

class MovieSuggestionCard extends StatelessWidget {
  final SuggestionMovies suggMovie;
  const MovieSuggestionCard({super.key, required this.suggMovie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (suggMovie.mediumCoverImage != null && suggMovie.mediumCoverImage!.isNotEmpty)
            Image.network(
              suggMovie.mediumCoverImage!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                );
              },
            )
          else
            Container(
              color: Colors.grey[800],
              child: const Center(
                child: Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),


          Positioned(
            top: 9,
            left: 9,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.black.withAlpha(90),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    suggMovie.rating?.toStringAsFixed(2) ?? 'N/A',
                    style: context.text.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
