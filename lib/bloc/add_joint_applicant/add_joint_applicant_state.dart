import 'package:equatable/equatable.dart';
import '../../model/response/add_joint_applicant_response_model.dart';
import '../../model/response/common_response_model.dart';

abstract class AddJointApplicantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddJointApplicantInitial extends AddJointApplicantState {}

class AddJointApplicantLoading extends AddJointApplicantState {}

class AddJointApplicantSuccess extends AddJointApplicantState {
  final AddJointApplicantResponseModel addJointApplicantResponseModel;

  AddJointApplicantSuccess({required this.addJointApplicantResponseModel});

  @override
  List<Object?> get props => [addJointApplicantResponseModel];
}

class AddJointApplicantFail extends AddJointApplicantState {
  final CommonResponseModel commonResponseModel;
  AddJointApplicantFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
