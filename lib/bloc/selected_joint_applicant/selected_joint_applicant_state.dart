import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/selected_joint_applicant_response_model.dart';

abstract class SelectedJointApplicantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectedJointApplicantInitial extends SelectedJointApplicantState {}

class SelectedJointApplicantLoading extends SelectedJointApplicantState {}

class SelectedJointApplicantSuccess extends SelectedJointApplicantState {
  final SelectedJointApplicantResponseModel selectedJointApplicantResponseModel;

  SelectedJointApplicantSuccess({required this.selectedJointApplicantResponseModel});

  @override
  List<Object?> get props => [selectedJointApplicantResponseModel];
}

class SelectedJointApplicantFail extends SelectedJointApplicantState {
  final CommonResponseModel commonResponseModel;
  SelectedJointApplicantFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
