import 'dart:convert';

JointApplicantInfoCubitModel jointApplicantInfoCubitModelFromJson(String str) =>
    JointApplicantInfoCubitModel.fromJson(json.decode(str));

String jointApplicantInfoCubitModelToJson(JointApplicantInfoCubitModel data) =>
    json.encode(data.toJson());

class JointApplicantInfoCubitModel {
  int? farmerId;
  int? genderId;
  String? name;
  String? idProofNumber;
  int? relationId;
  int? idProofId;
  String? dateOfBirth;

  JointApplicantInfoCubitModel(
      {this.farmerId,
      this.genderId,
      this.dateOfBirth,
      this.idProofId,
      this.relationId,
      this.idProofNumber,
      this.name});

  JointApplicantInfoCubitModel copyWith({
    int? farmerId,
    int? genderId,
    String? name,
    String? idProofNumber,
    int? relationId,
    int? idProofId,
    String? dateOfBirth,
  }) =>
      JointApplicantInfoCubitModel(
          farmerId: farmerId ?? this.farmerId,
          genderId: genderId ?? this.genderId,
          name: name ?? this.name,
          idProofNumber: idProofNumber ?? this.dateOfBirth,
          relationId: relationId ?? this.relationId,
          idProofId: idProofId ?? this.idProofId,
          dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );

  factory JointApplicantInfoCubitModel.fromJson(Map<String, dynamic> json) =>
      JointApplicantInfoCubitModel(
        farmerId: json['farmerId'],
        name: json['name'],
        idProofNumber: json['idProofNumber'],
        idProofId: json['idProofId'],
        genderId: json["genderId"],
        dateOfBirth: json["dateOfBirth"],

      );

  Map<String, dynamic> toJson() => {
        "farmerId" :farmerId,
        "name" : name,
        "idProofNumber" : idProofNumber,
        "idProofId" : idProofId,
        "genderId": genderId,
        "dateOfBirth": dateOfBirth,
      };
}
