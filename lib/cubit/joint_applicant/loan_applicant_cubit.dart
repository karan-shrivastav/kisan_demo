import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/response/loan_joint_applicant_model.dart';

class LoanJointApplicantInfoCubit
    extends Cubit<LoanJointApplicantInfoCubitModel> {
  LoanJointApplicantInfoCubit() : super(LoanJointApplicantInfoCubitModel());

  void updateModel({
    int? genderId,
    int? idProofId,
    int? relationId,
    String? dateOfBirth,
  }) {
    emit(state.copyWith(
      genderId: genderId ?? state.genderId,
      idProofId: idProofId ?? state.idProofId,
      relationId: relationId ?? state.relationId,
      dateOfBirth: dateOfBirth ?? state.dateOfBirth,
    ));
  }

  void clear() {
    emit(LoanJointApplicantInfoCubitModel());
  }
}
