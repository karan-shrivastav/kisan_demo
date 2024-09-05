import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/save_other_details_response_model.dart';

abstract class SaveOtherDetailsNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveOtherDetailsNewInitial extends SaveOtherDetailsNewState {}

class SaveOtherDetailsNewLoading extends SaveOtherDetailsNewState {}

class SaveOtherDetailsNewSuccess extends SaveOtherDetailsNewState {
  final SaveOtherDetailsSuccessResponseModel
      saveOtherDetailsSuccessResponseModel;

  SaveOtherDetailsNewSuccess(
      {required this.saveOtherDetailsSuccessResponseModel});

  @override
  List<Object?> get props => [saveOtherDetailsSuccessResponseModel];
}

class SaveOtherDetailsNewFail extends SaveOtherDetailsNewState {
  final CommonResponseModel commonResponseModel;

  SaveOtherDetailsNewFail({required this.commonResponseModel});
}
