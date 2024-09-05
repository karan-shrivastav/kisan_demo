import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/create_farmer_userinfo_cubit_model.dart';

class CreateFarmerUserInfoCubit
    extends Cubit<CreateFarmerUserProfileInfoCubitModel> {
  CreateFarmerUserInfoCubit() : super(CreateFarmerUserProfileInfoCubitModel());

  void updateModel(
      {int? titleId,
      int? genderId,
      int? religionId,
      int? casteId,
      int? occupationId,
      int? proofOfIdentityId,
      String? physicallyHandicapped,
      String? fullName,
      String? dateOfBirth,
      String? sdwOf,
      String? relativeName,
      String? aadhaarNo,
      String? idProofNo,
      String? aadhaarAddress,
      String? casteName,
      String? selectedProofOfIdentityString,
      String? mobileNumber,
      String? email,
      String? selectedRegionString,
      String? selectedOccupationString,
      bool? showErrorForTitle,
      bool? showErrorForGender}) {
    emit(state.copyWith(
        titleId: titleId ?? state.titleId,
        genderId: genderId ?? state.genderId,
        religionId: religionId ?? state.religionId,
        casteId: casteId ?? state.casteId,
        occupationId: occupationId ?? state.occupationId,
        proofOfIdentityId: proofOfIdentityId ?? state.proofOfIdentityId,
        physicallyHandicapped:
            physicallyHandicapped ?? state.physicallyHandicapped,
        fullName: fullName ?? state.fullName,
        dateOfBirth: dateOfBirth ?? state.dateOfBirth,
        sdwOf: sdwOf ?? state.sdwOf,
        relativeName: relativeName ?? state.relativeName,
        aadhaarNo: aadhaarNo ?? state.aadhaarNo,
        aadhaarAddress: aadhaarAddress ?? state.aadhaarAddress,
        casteName: casteName ?? state.casteName,
        idProofNo: idProofNo ?? state.idProofNo,
        selectedProofOfIdentityString: selectedProofOfIdentityString ??
            state.selectedProofOfIdentityString,
        mobileNumber: mobileNumber ?? state.mobileNumber,
        email: email ?? state.email,
        selectedRegionString:
            selectedRegionString ?? state.selectedRegionString,
        selectedOccupationString:
            selectedOccupationString ?? state.selectedOccupationString,
        showErrorForTitle: showErrorForTitle ?? state.showErrorForTitle,
        showErrorForGender: showErrorForGender ?? state.showErrorForGender));
  }

  void clear() {
    emit(CreateFarmerUserProfileInfoCubitModel());
  }
  void clearSpecificField(String fieldName) {
    emit(state.copyWith(
        titleId: fieldName == 'titleId' ? null : state.titleId,
        genderId: fieldName == 'genderId' ? null : state.genderId,
        religionId: fieldName == 'religionId' ? null : state.religionId,
        casteId: fieldName == 'casteId' ? null : state.casteId,
        occupationId: fieldName == 'occupationId' ? null : state.occupationId,
        proofOfIdentityId: fieldName == 'proofOfIdentityId' ? null : state.proofOfIdentityId,
        physicallyHandicapped: fieldName == 'physicallyHandicapped' ? null : state.physicallyHandicapped,
        fullName: fieldName == 'fullName' ? null : state.fullName,
        dateOfBirth: fieldName == 'dateOfBirth' ? null : state.dateOfBirth,
        sdwOf: fieldName == 'sdwOf' ? null : state.sdwOf,
        relativeName: fieldName == 'relativeName' ? null : state.relativeName,
        aadhaarNo: fieldName == 'aadhaarNo' ? null : state.aadhaarNo,
        idProofNo: fieldName == 'idProofNo' ? null : state.idProofNo,
        aadhaarAddress: fieldName == 'aadhaarAddress' ? null : state.aadhaarAddress,
        casteName: fieldName == 'casteName' ? null : state.casteName,
        selectedProofOfIdentityString: fieldName == 'selectedProofOfIdentityString' ? null : state.selectedProofOfIdentityString,
        mobileNumber: fieldName == 'mobileNumber' ? null : state.mobileNumber,
        email: fieldName == 'email' ? null : state.email,
        selectedRegionString: fieldName == 'selectedRegionString' ? null : state.selectedRegionString,
        selectedOccupationString: fieldName == 'selectedOccupationString' ? null : state.selectedOccupationString,
        showErrorForTitle: fieldName == 'showErrorForTitle' ? null : state.showErrorForTitle,
        showErrorForGender: fieldName == 'showErrorForGender' ? null : state.showErrorForGender
    ));
  }
}
