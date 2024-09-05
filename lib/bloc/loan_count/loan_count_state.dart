import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/check_kyc_response_model.dart';
import '../../model/response/loan_count_response_model.dart';

abstract class LoanCountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLoanCountInitial extends LoanCountState {}

class GetLoanCountLoading extends LoanCountState {}

class GetLoanCountSuccess extends LoanCountState {
  final LoanCountResponseModel loanCountResponseModel;

  GetLoanCountSuccess({required this.loanCountResponseModel});

  @override
  List<Object?> get props => [loanCountResponseModel];
}

class GetLoanCountFail extends LoanCountState {
  final CommonResponseModel commonResponseModel;

  GetLoanCountFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
