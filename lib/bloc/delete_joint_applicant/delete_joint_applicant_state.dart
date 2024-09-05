import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/delete_joint_applicant_response_model.dart';

abstract class DeleteJointApplicantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteJointApplicantInitial extends DeleteJointApplicantState {}

class DeleteJointApplicantLoading extends DeleteJointApplicantState {}

class DeleteJointApplicantSuccess extends DeleteJointApplicantState {
  final DeleteJointApplicantResponseModel deleteJointApplicantResponseModel;

  DeleteJointApplicantSuccess({required this.deleteJointApplicantResponseModel});

  @override
  List<Object?> get props => [deleteJointApplicantResponseModel];
}

class DeleteJointApplicantFail extends DeleteJointApplicantState {
  final CommonResponseModel commonResponseModel;
  DeleteJointApplicantFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
