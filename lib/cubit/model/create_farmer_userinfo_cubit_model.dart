// To parse this JSON data, do
//
//     final createFarmerUserProfileInfoCubitModel = createFarmerUserProfileInfoCubitModelFromJson(jsonString);

import 'dart:convert';

CreateFarmerUserProfileInfoCubitModel
    createFarmerUserProfileInfoCubitModelFromJson(String str) =>
        CreateFarmerUserProfileInfoCubitModel.fromJson(json.decode(str));

String createFarmerUserProfileInfoCubitModelToJson(
        CreateFarmerUserProfileInfoCubitModel data) =>
    json.encode(data.toJson());

class CreateFarmerUserProfileInfoCubitModel {
  int? titleId;
  int? genderId;
  int? religionId;
  int? casteId;
  int? occupationId;
  int? proofOfIdentityId;
  String? physicallyHandicapped;
  String? fullName;
  String? dateOfBirth;
  String? sdwOf;
  String? relativeName;
  String? aadhaarNo;
  String? idProofNo;
  String? aadhaarAddress;
  String? casteName;
  String? selectedProofOfIdentityString;
  String? mobileNumber;
  String? email;
  String? selectedRegionString;
  String? selectedOccupationString;
  bool? showErrorForTitle;
  bool? showErrorForGender;

  CreateFarmerUserProfileInfoCubitModel(
      {this.titleId,
      this.genderId,
      this.religionId,
      this.casteId,
      this.occupationId,
      this.proofOfIdentityId,
      this.physicallyHandicapped,
      this.fullName,
      this.dateOfBirth,
      this.sdwOf,
      this.relativeName,
      this.aadhaarNo,
      this.idProofNo,
      this.aadhaarAddress,
      this.casteName,
      this.selectedProofOfIdentityString,
      this.mobileNumber,
      this.email,
      this.selectedRegionString,
      this.selectedOccupationString,
      this.showErrorForTitle,
      this.showErrorForGender});

  CreateFarmerUserProfileInfoCubitModel copyWith({
    int? titleId,
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
    bool? showErrorForGender,
  }) =>
      CreateFarmerUserProfileInfoCubitModel(
          titleId: titleId ?? this.titleId,
          genderId: genderId ?? this.genderId,
          religionId: religionId ?? this.religionId,
          casteId: casteId ?? this.casteId,
          occupationId: occupationId ?? this.occupationId,
          proofOfIdentityId: proofOfIdentityId ?? this.proofOfIdentityId,
          physicallyHandicapped:
              physicallyHandicapped ?? this.physicallyHandicapped,
          fullName: fullName ?? this.fullName,
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
          sdwOf: sdwOf ?? this.sdwOf,
          relativeName: relativeName ?? this.relativeName,
          aadhaarNo: aadhaarNo ?? this.aadhaarNo,
          idProofNo: idProofNo ?? this.idProofNo,
          aadhaarAddress: aadhaarAddress ?? this.aadhaarAddress,
          casteName: casteName ?? this.casteName,
          selectedProofOfIdentityString: selectedProofOfIdentityString ??
              this.selectedProofOfIdentityString,
          mobileNumber: mobileNumber ?? this.mobileNumber,
          email: email ?? this.email,
          selectedRegionString:
              selectedRegionString ?? this.selectedRegionString,
          selectedOccupationString:
              selectedOccupationString ?? this.selectedOccupationString,
          showErrorForTitle: showErrorForTitle ?? this.showErrorForTitle,
          showErrorForGender: showErrorForGender ?? this.showErrorForGender);

  factory CreateFarmerUserProfileInfoCubitModel.fromJson(
          Map<String, dynamic> json) =>
      CreateFarmerUserProfileInfoCubitModel(
        titleId: json["titleId"],
        genderId: json["genderId"],
        religionId: json["religionId"],
        casteId: json["casteId"],
        occupationId: json["occupationId"],
        proofOfIdentityId: json["proofOfIdentityId"],
        physicallyHandicapped: json["physicallyHandicapped"],
        fullName: json["fullName"],
        dateOfBirth: json["dateOfBirth"],
        sdwOf: json["sdwOf"],
        relativeName: json["relativeName"],
        aadhaarNo: json["aadhaarNo"],
        idProofNo: json["idProofNo"],
        aadhaarAddress: json["aadhaarAddress"],
        casteName: json["casteName"],
        selectedProofOfIdentityString: json["selectedProofOfIdentityString"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        selectedRegionString: json["selectedRegionString"],
        selectedOccupationString: json["selectedOccupationString"],
        showErrorForTitle: json["showErrorForTitle"],
        showErrorForGender: json["showErrorForGender"],
      );

  Map<String, dynamic> toJson() => {
        "titleId": titleId,
        "genderId": genderId,
        "religionId": religionId,
        "casteId": casteId,
        "occupationId": occupationId,
        "proofOfIdentityId": proofOfIdentityId,
        "physicallyHandicapped": physicallyHandicapped,
        "fullName": fullName,
        "dateOfBirth": dateOfBirth,
        "sdwOf": sdwOf,
        "relativeName": relativeName,
        "aadhaarNo": aadhaarNo,
        "idProofNo": idProofNo,
        "aadhaarAddress": aadhaarAddress,
        "casteName": casteName,
        "selectedProofOfIdentityString": selectedProofOfIdentityString,
        "mobileNumber": mobileNumber,
        "email": email,
        "selectedRegionString": selectedRegionString,
        "selectedOccupationString": selectedOccupationString,
        "showErrorForTitle": showErrorForTitle,
        "showErrorForGender": showErrorForGender,
      };
}
