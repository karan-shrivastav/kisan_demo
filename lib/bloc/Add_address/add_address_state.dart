import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/create_farmer_address_response_model.dart';

abstract class AddAddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAddressInitial extends AddAddressState {}

class AddAddressLoading extends AddAddressState {}

class AddAddressSuccess extends AddAddressState {
  final CreateFarmerAddressResponseModel createFarmerAddressResponseModel;

  AddAddressSuccess({required this.createFarmerAddressResponseModel});

  @override
  List<Object?> get props => [createFarmerAddressResponseModel];
}

class AddAddressFail extends AddAddressState {
  final CommonResponseModel commonResponseModel;

  AddAddressFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
