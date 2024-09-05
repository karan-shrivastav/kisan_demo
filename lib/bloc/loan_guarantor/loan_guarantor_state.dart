import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_guarantors_response_model.dart';

abstract class LoanGuarantorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoanGuarantorInitial extends LoanGuarantorState {}

class LoanGuarantorLoading extends LoanGuarantorState {}

class LoanGuarantorSuccess extends LoanGuarantorState {
  final LoanGuarantorResponseModel loanGuarantorResponseModel;

  LoanGuarantorSuccess({required this.loanGuarantorResponseModel});

  @override
  List<Object?> get props => [loanGuarantorResponseModel];
}

class LoanGuarantorFail extends LoanGuarantorState {
  final CommonResponseModel commonResponseModel;
  LoanGuarantorFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
