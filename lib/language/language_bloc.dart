import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../Utils/shared_preference_helper.dart';
import 'language_state.dart';



class LanguageEvent {
  final Locale locale;
  LanguageEvent(this.locale);
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      emit(LanguageLoaded(event.locale));
    });
  }
}