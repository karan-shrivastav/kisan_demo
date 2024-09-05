
import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/delete_land_response.dart';

abstract class DeleteLandDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteDataInitial extends DeleteLandDataState {}

class DeleteLandDataLoading extends  DeleteLandDataState {}

class DeleteLandDataSuccess extends DeleteLandDataState {
  final DeleteLandResponse deleteLandResponseModel;
  DeleteLandDataSuccess({required this.deleteLandResponseModel});
  @override
  List<Object?> get props => [deleteLandResponseModel];
}

class DeleteLandDataFail extends DeleteLandDataState {
  final CommonResponseModel commonResponseModel;
  DeleteLandDataFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
