import 'package:equatable/equatable.dart';

import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_guarantor_preview_response_model.dart';

abstract class LoanNewDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoanNewDetailsStateInitial extends LoanNewDetailsState {}

class LoanNewDetailsStateLoading extends LoanNewDetailsState {}

class LoanNewDetailsStateSuccess extends LoanNewDetailsState {
  final LoanNewDetailsResponseModel loanNewDetailsResponseModel;

  LoanNewDetailsStateSuccess({required this.loanNewDetailsResponseModel});

  @override
  List<Object> get props => [loanNewDetailsResponseModel];
}

class LoanNewDetailsStateFail extends LoanNewDetailsState {
  final CommonResponseModel commonResponseModel;

  LoanNewDetailsStateFail({required this.commonResponseModel});
}
