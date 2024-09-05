import 'package:equatable/equatable.dart';

abstract class StateEventNew extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllState extends StateEventNew{}
class ClearAllState extends StateEventNew{}