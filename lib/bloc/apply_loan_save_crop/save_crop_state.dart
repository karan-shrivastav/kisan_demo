import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/save_crop_resposne_model.dart';


abstract class SaveCropNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveCropNewInitial extends SaveCropNewState {}

class SaveCropNewLoading extends SaveCropNewState {}

class SaveCropNewSuccess extends SaveCropNewState {
  final SaveCropResponseModel saveCropResponseModel;

  SaveCropNewSuccess({required this.saveCropResponseModel});

  @override
  List<Object?> get props => [saveCropResponseModel];
}

class SaveCropNewFail extends SaveCropNewState {
  final CommonResponseModel commonResponseModel ;
  SaveCropNewFail({required this.commonResponseModel});

}