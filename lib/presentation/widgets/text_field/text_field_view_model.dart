import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies/presentation/widgets/text_field/text_field_contract.dart';

class TextFieldViewModel extends Bloc<TextFieldAction,TextFieldState>{
  TextFieldViewModel():super(TextFieldState(true)){
    on<TextFieldAction>(_visibility);
  }



  Future _visibility(TextFieldAction action,Emitter emitter)async {
    emitter(TextFieldState(!state.isObscured));


  }
}