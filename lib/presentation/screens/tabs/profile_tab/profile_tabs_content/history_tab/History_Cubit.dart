import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/data/movies_details/movies_details_data.dart';

class HistoryCubit extends Cubit<List<MoviesDetailsData>> {
  HistoryCubit() : super(const []);

  void addMovie(MoviesDetailsData movie) {
    final exists = state.any(
          (m) => m.data?.movie?.id == movie.data?.movie?.id,
    );

    if (exists) return;

    emit(List.unmodifiable([movie, ...state]));
  }

  int get count => state.length;

  void clearHistory() {
    emit(const []);
  }
}
