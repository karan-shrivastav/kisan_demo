import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LanguageChanged extends LanguageEvent {
  final Locale locale;
  LanguageChanged(this.locale);

  @override
  List<Object> get props => [locale];
}
