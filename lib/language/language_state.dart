import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final Locale locale;
  LanguageLoaded(this.locale);

  @override
  List<Object> get props => [locale];
}
