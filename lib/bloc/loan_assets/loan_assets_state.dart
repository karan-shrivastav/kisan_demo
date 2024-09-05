import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_assets_response_model.dart';

abstract class LoanAssetsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoanAssetsInitial extends LoanAssetsState {}

class LoanAssetsLoading extends LoanAssetsState {}

class LoanAssetsSuccess extends LoanAssetsState {
  final LoanAssetsResponseModel loanAssetsResponseModel;

  LoanAssetsSuccess({required this.loanAssetsResponseModel});

  @override
  List<Object?> get props => [loanAssetsResponseModel];
}

class LoanAssetsFail extends LoanAssetsState {
  final CommonResponseModel commonResponseModel;
  LoanAssetsFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
