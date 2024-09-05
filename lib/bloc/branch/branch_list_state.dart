import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_branch_list_response_model.dart';

abstract class BranchListNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewBranchListInitial extends BranchListNewState {}

class GetNewBranchListLoading extends BranchListNewState {}

class GetNewBranchListSuccess extends BranchListNewState {
  final BranchListResponseModel branchListResponseModel;

  GetNewBranchListSuccess({required this.branchListResponseModel});

  @override
  List<Object?> get props => [branchListResponseModel];
}

class GetNewBranchListFail extends BranchListNewState {
  final CommonResponseModel commonResponseModel;

  GetNewBranchListFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
