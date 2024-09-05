import 'package:equatable/equatable.dart';

import '../../model/response/bank_list_response_model.dart';
import '../../model/response/common_response_model.dart';


abstract class BankListNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBankListNewInitial extends BankListNewState {}

class GetBankListNewLoading extends BankListNewState {}

class GetBankListNewSuccess extends BankListNewState {
  final BankListResponseModel bankListResponseModel;

  GetBankListNewSuccess({required this.bankListResponseModel});

  @override
  List<Object?> get props => [bankListResponseModel];
}

class GetBankListNewFail extends BankListNewState {
  final CommonResponseModel commonResponseModel;

  GetBankListNewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
