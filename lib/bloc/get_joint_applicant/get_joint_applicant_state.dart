import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_joint_applicant_response_model.dart';

abstract class GetJointApplicantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetJointApplicantInitial extends GetJointApplicantState {}

class GetJointApplicantLoading extends GetJointApplicantState {}

class GetJointApplicantSuccess extends GetJointApplicantState {
  final GetJointApplicantResponseModel getJointApplicantResponseModel;

  GetJointApplicantSuccess({required this.getJointApplicantResponseModel});

  @override
  List<Object?> get props => [getJointApplicantResponseModel];
}

class GetJointApplicantFail extends GetJointApplicantState {
  final CommonResponseModel commonResponseModel;
  GetJointApplicantFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
