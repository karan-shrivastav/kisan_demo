import 'package:equatable/equatable.dart';

import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_asset_preview_response_model.dart';

abstract class LoanAssetPreviewNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoanAssetPreviewNewInitial extends LoanAssetPreviewNewState {}

class LoanAssetPreviewNewLoading extends LoanAssetPreviewNewState {}

class LoanAssetPreviewNewSuccess extends LoanAssetPreviewNewState {
  final GetLoanAssetNewPreviewResponseModel getLoanAssetNewPreviewResponseModel;

  LoanAssetPreviewNewSuccess(
      {required this.getLoanAssetNewPreviewResponseModel});

  @override
  List<Object?> get props => [getLoanAssetNewPreviewResponseModel];
}

class LoanAssetPreviewNewFail extends LoanAssetPreviewNewState {
  final CommonResponseModel commonResponseModel;

  LoanAssetPreviewNewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
