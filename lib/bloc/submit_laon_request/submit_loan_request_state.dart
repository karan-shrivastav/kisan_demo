import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/submit_loan_response_model.dart';

abstract class SubmitLoanRequestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitLoanRequestNewInitial extends SubmitLoanRequestState {}

class SubmitLoanRequestNewLoading extends SubmitLoanRequestState {}

class SubmitLoanRequestNewSuccess extends SubmitLoanRequestState {
  final LoanSubmitResponseModel loanSubmitResponseModel;

  SubmitLoanRequestNewSuccess({required this.loanSubmitResponseModel});

  @override
  List<Object?> get props => [loanSubmitResponseModel];
}

class SubmitLoanRequestNewFail extends SubmitLoanRequestState {
  final CommonResponseModel commonResponseModel;

  SubmitLoanRequestNewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
