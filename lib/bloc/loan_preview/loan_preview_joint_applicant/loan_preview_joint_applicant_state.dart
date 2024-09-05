import 'package:equatable/equatable.dart';

import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_preview_joint_applicant_response_model.dart';


abstract class PreviewBasicsDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreviewBasicsDetailsInitial extends PreviewBasicsDetailsState {}

class PreviewBasicsDetailsLoading extends PreviewBasicsDetailsState {}

class PreviewBasicsDetailSuccess extends PreviewBasicsDetailsState {
  final BasicDetailsNewResponseModel basicDetailsNewResponseModel;

  PreviewBasicsDetailSuccess({required this.basicDetailsNewResponseModel});

  @override
  List<Object> get props => [basicDetailsNewResponseModel];
}

class PreviewBasicsDetailFail extends PreviewBasicsDetailsState {
  final CommonResponseModel commonResponseModel;

  PreviewBasicsDetailFail({required this.commonResponseModel});
}
