import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_all_state_response_model.dart';

abstract class StateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStateInitial extends StateState {}

class GetStateLoading extends StateState {}

class GetStateSuccess extends StateState {
  final GetAllStateResponseModel getAllStateResponseModel;

  GetStateSuccess({required this.getAllStateResponseModel});

  @override
  List<Object?> get props => [getAllStateResponseModel];
}

class GetStateFail extends StateState {
  final CommonResponseModel commonResponseModel;

  GetStateFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
