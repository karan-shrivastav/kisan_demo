import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_basic_response_model.dart';


abstract class GetBasicLoanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBasicLoanInitial extends GetBasicLoanState {}

class GetBasicLoanLoading extends GetBasicLoanState {}

class GetBasicLoanSuccess extends GetBasicLoanState {
  final LoanBasicResponseModel  loanBasicResponseModel;

  GetBasicLoanSuccess({required this.loanBasicResponseModel});

  @override
  List<Object?> get props => [loanBasicResponseModel];
}

class GetBasicLoanFail extends GetBasicLoanState {
  final CommonResponseModel commonResponseModel;

  GetBasicLoanFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
