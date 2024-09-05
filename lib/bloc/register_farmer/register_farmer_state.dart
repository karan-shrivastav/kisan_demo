import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/register_farmer_response_model.dart';

abstract class RegisterFarmerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterFarmerInitial extends RegisterFarmerState {}

class RegisterFarmerLoading extends RegisterFarmerState {}

class RegisterFarmerSuccess extends RegisterFarmerState {
  final RegisterFarmerResponseModel registerFarmerResponseModel;

  RegisterFarmerSuccess({required this.registerFarmerResponseModel});

  @override
  List<Object?> get props => [registerFarmerResponseModel];
}

class RegisterFarmerFail extends RegisterFarmerState {
  final CommonResponseModel commonResponseModel;

  RegisterFarmerFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}

class CreateFarmerUserInfoInitial extends RegisterFarmerState {}

class CreateFarmerUserInfoLoading extends RegisterFarmerState {}

class CreateFarmerUserInfoSuccess extends RegisterFarmerState {
  final CommonResponseModel commonResponseModel;

  CreateFarmerUserInfoSuccess({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}

class CreateFarmerUserInfoFail extends RegisterFarmerState {
  final CommonResponseModel commonResponseModel;

  CreateFarmerUserInfoFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
