import 'package:equatable/equatable.dart';

import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_details_preview_response_model.dart';

abstract class LoanDetailsNewPreviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoanDetailsNewPreviewInitial extends LoanDetailsNewPreviewState {}

class LoanDetailsNewPreviewLoading extends LoanDetailsNewPreviewState {}

class LoanDetailsNewPreviewSuccess extends LoanDetailsNewPreviewState {
  final LoanDetailsNewPreviewResponseModel loanDetailsNewPreviewResponseModel;

  LoanDetailsNewPreviewSuccess(
      {required this.loanDetailsNewPreviewResponseModel});

  @override
  List<Object?> get props => [loanDetailsNewPreviewResponseModel];
}

class LoanDetailsNewPreviewFail extends LoanDetailsNewPreviewState {
  final CommonResponseModel commonResponseModel;

  LoanDetailsNewPreviewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
