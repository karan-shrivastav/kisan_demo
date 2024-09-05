import 'package:equatable/equatable.dart';

import '../../model/response/apply_loan_request_response_model.dart';
import '../../model/response/common_response_model.dart';


class ApplyLoanRequestState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApplyLoanRequestInitial extends ApplyLoanRequestState {}

class ApplyLoanRequestLoading extends ApplyLoanRequestState {}

class ApplyLoanRequestSuccess extends ApplyLoanRequestState {
  final ApplyLoanRequestResponseModel applyLoanRequestResponseModel;

  ApplyLoanRequestSuccess({required this.applyLoanRequestResponseModel});

  @override
  List<Object?> get props => [applyLoanRequestResponseModel];
}

class ApplyLoanRequestFail extends ApplyLoanRequestState {
  final CommonResponseModel commonResponseModel;

  ApplyLoanRequestFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
