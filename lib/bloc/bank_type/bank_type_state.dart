import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_all_bank_type_response_model.dart';

abstract class BankTypeNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBankTypeInitial extends BankTypeNewState {}

class GetBankTypeLoading extends BankTypeNewState {}

class GetBankTypeSuccess extends BankTypeNewState {
  final GetAllBankTypeResponseModel getAllBankTypeResponseModel;

  GetBankTypeSuccess({required this.getAllBankTypeResponseModel});

  @override
  List<Object?> get props => [getAllBankTypeResponseModel];
}

class GetBankTypeFail extends BankTypeNewState {
  final CommonResponseModel commonResponseModel;

  GetBankTypeFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
