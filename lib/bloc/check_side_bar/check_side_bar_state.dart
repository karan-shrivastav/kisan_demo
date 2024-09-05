import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/check_side_bar_response_model.dart';

abstract class CheckSideBarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckSideBarInitial extends CheckSideBarState {}

class CheckSidebarLoading extends CheckSideBarState {}

class CheckSideBarSuccess extends CheckSideBarState {
  final CheckSideBarResponseModel checkSideBarResponseModel;

  CheckSideBarSuccess({required this.checkSideBarResponseModel});

  @override
  List<Object?> get props => [checkSideBarResponseModel];
}

class CheckSideBarFail extends CheckSideBarState {
  final CommonResponseModel commonResponseModel;

  CheckSideBarFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
