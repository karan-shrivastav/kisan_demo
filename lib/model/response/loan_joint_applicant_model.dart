import 'dart:convert';

LoanJointApplicantInfoCubitModel loanJointApplicantInfoCubitModelFromJson(
        String str) =>
    LoanJointApplicantInfoCubitModel.fromJson(json.decode(str));

String loanJointApplicantInfoCubitModelToJson(
        LoanJointApplicantInfoCubitModel data) =>
    json.encode(data.toJson());

class LoanJointApplicantInfoCubitModel {
  int? genderId;
  int? idProofId;
  int? relationId;
  String? dateOfBirth;

  LoanJointApplicantInfoCubitModel({
    this.genderId,
    this.idProofId,
    this.relationId,
    this.dateOfBirth,
  });

  LoanJointApplicantInfoCubitModel copyWith({
    int? genderId,
    int? idProofId,
    int? relationId,
    String? dateOfBirth
  }) =>
      LoanJointApplicantInfoCubitModel(
        genderId: genderId ?? this.genderId,
        idProofId: idProofId ?? this.idProofId,
        relationId: relationId ?? this.relationId,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );

  factory LoanJointApplicantInfoCubitModel.fromJson(
          Map<String, dynamic> json) =>
      LoanJointApplicantInfoCubitModel(
        genderId: json["genderId"],
        idProofId: json["idProofId"],
        relationId: json["relationId"],
        dateOfBirth:  json["dateOfBirth"]
      );

  Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "idProofId": idProofId,
        "relationId" : relationId,
        "dateOfBirth": dateOfBirth,
      };
}
