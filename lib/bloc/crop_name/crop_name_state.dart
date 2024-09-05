import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_crop_name_list_response_model.dart';

abstract class CropNameNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCropNameNewInitial extends CropNameNewState {}

class GetCropNameNewLoading extends CropNameNewState {}

class GetCropNameNewSuccess extends CropNameNewState {
  final GetCropNameListResponseModel getCropNameListResponseModel;

  GetCropNameNewSuccess({required this.getCropNameListResponseModel});

  @override
  List<Object?> get props => [getCropNameListResponseModel];
}

class GetCropNameNewFail extends CropNameNewState {
  final CommonResponseModel commonResponseModel;

  GetCropNameNewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
