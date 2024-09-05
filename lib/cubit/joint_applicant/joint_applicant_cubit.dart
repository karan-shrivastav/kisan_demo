import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/joint_applicant_cubit_model.dart';

class JointApplicantInfoCubit extends Cubit<JointApplicantInfoCubitModel> {
  JointApplicantInfoCubit() : super(JointApplicantInfoCubitModel());

  void updateModel(
      {int? farmerId,
      int? genderId,
      String? name,
      String? idProofNumber,
      int? relationId,
      int? idProofId,
      String? dateOfBirth}) {
    emit(state.copyWith(
      farmerId: farmerId ?? state.farmerId,
      genderId: genderId ?? state.genderId,
      name: name ?? state.name,
      idProofNumber: idProofNumber ?? state.idProofNumber,
      relationId: relationId ?? state.relationId,
      idProofId: idProofId ?? state.idProofId,
      dateOfBirth: dateOfBirth ?? state.dateOfBirth,
    ));
  }

  void clear() {
    emit(JointApplicantInfoCubitModel());
  }
}
