// To parse this JSON data, do
//
//     final farmerFamilyMemberCubitModel = farmerFamilyMemberCubitModelFromJson(jsonString);

import 'dart:convert';

FarmerFamilyMemberCubitModel farmerFamilyMemberCubitModelFromJson(String str) =>
    FarmerFamilyMemberCubitModel.fromJson(json.decode(str));

String farmerFamilyMemberCubitModelToJson(FarmerFamilyMemberCubitModel data) =>
    json.encode(data.toJson());

class FarmerFamilyMemberCubitModel {
  int? genderId;
  int? nomineeRelationId;
  int? nomineeOccupationId;
  String? nomineeName;
  String? nomineeAge;
  String? annualIncome;
  String? relationName;

  FarmerFamilyMemberCubitModel({
    this.genderId,
    this.nomineeRelationId,
    this.nomineeOccupationId,
    this.nomineeName,
    this.nomineeAge,
    this.annualIncome,
    this.relationName,
  });

  FarmerFamilyMemberCubitModel copyWith({
    int? genderId,
    int? nomineeRelationId,
    int? nomineeOccupationId,
    String? nomineeName,
    String? nomineeAge,
    String? annualIncome,
    String? relationName,
  }) =>
      FarmerFamilyMemberCubitModel(
        genderId: genderId ?? this.genderId,
        nomineeRelationId: nomineeRelationId ?? this.nomineeRelationId,
        nomineeOccupationId: nomineeOccupationId ?? this.nomineeOccupationId,
        nomineeName: nomineeName ?? this.nomineeName,
        nomineeAge: nomineeAge ?? this.nomineeAge,
        annualIncome: annualIncome ?? this.annualIncome,
        relationName: relationName ?? this.relationName,
      );

  factory FarmerFamilyMemberCubitModel.fromJson(Map<String, dynamic> json) =>
      FarmerFamilyMemberCubitModel(
        genderId: json["genderId"],
        nomineeRelationId: json["nomineeRelationId"],
        nomineeOccupationId: json["nomineeOccupationId"],
        nomineeName: json["nomineeName"],
        nomineeAge: json["nomineeAge"],
        annualIncome: json["annualIncome"],
        relationName: json["relationName"]
      );

  Map<String, dynamic> toJson() => {
        "genderId": genderId,
        "nomineeRelationId": nomineeRelationId,
        "nomineeOccupationId": nomineeOccupationId,
        "nomineeName": nomineeName,
        "nomineeAge": nomineeAge,
        "annualIncome": annualIncome,
        "relationName" : relationName,
      };
}
