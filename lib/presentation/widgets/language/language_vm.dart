import 'package:bloc/bloc.dart';
import 'package:movies/presentation/widgets/language/language_contract.dart';

class LanguageViewModel extends Bloc<LocalizationAction, LocalizationState> {
  LanguageViewModel() : super(LocalizationState()) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(LocalizationState(locale: event.locale));
    });
  }
}