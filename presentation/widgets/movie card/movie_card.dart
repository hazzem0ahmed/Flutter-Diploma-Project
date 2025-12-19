import 'package:flutter/material.dart';
import 'package:movies/core/app_extensions.dart';
import '../../../core/app_colors.dart';
import '../../../features/data/moviesList/movies_list_data.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;

  const MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.spaceWidth * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (movie.mediumCoverImage != null &&
                movie.mediumCoverImage!.isNotEmpty)
              Image.network(
                movie.mediumCoverImage!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.movie_creation_outlined,
                      color: Colors.white,
                      size: 40,
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
                    size: 40,
                  ),
                ),
              ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.black.withAlpha(90),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.rating?.toStringAsFixed(1) ?? 'N/A',
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
      ),
    );
  }
}
