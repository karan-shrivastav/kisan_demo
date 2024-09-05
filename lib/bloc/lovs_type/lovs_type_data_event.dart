import 'package:equatable/equatable.dart';

abstract class LovsTypeDataNewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLovsTypeDataNewList extends LovsTypeDataNewEvent {
  final List<String> bodyRequest;
  GetLovsTypeDataNewList({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}
