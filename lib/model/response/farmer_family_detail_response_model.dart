// To parse this JSON data, do
//
//     final getFarmerFamilyDetailResponseModel = getFarmerFamilyDetailResponseModelFromJson(jsonString);

import 'dart:convert';

GetFarmerFamilyDetailResponseModel getFarmerFamilyDetailResponseModelFromJson(
        String str) =>
    GetFarmerFamilyDetailResponseModel.fromJson(json.decode(str));

String getFarmerFamilyDetailResponseModelToJson(
        GetFarmerFamilyDetailResponseModel data) =>
    json.encode(data.toJson());

class GetFarmerFamilyDetailResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<FamilyDataList>? dataList;

  GetFarmerFamilyDetailResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetFarmerFamilyDetailResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<FamilyDataList>? dataList,
  }) =>
      GetFarmerFamilyDetailResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetFarmerFamilyDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetFarmerFamilyDetailResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: List<FamilyDataList>.from(
            json["dataList"].map((x) => FamilyDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class FamilyDataList {
  int? farmerId;
  String? name;
  String? age;
  String? gender;
  int? genderId;
  String? relationWithApplicant;
  int? relationWithApplicantId;
  String? occupation;
  int? occupationId;
  String? annualIncome;
  int? id;

  FamilyDataList({
    this.farmerId,
    this.name,
    this.age,
    this.gender,
    this.genderId,
    this.relationWithApplicant,
    this.relationWithApplicantId,
    this.occupation,
    this.occupationId,
    this.annualIncome,
    this.id,
  });

  FamilyDataList copyWith({
    int? farmerId,
    String? name,
    String? age,
    String? gender,
    int? genderId,
    String? relationWithApplicant,
    int? relationWithApplicantId,
    String? occupation,
    int? occupationId,
    String? annualIncome,
    int? id,
  }) =>
      FamilyDataList(
        farmerId: farmerId ?? this.farmerId,
        name: name ?? this.name,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        genderId: genderId ?? this.genderId,
        relationWithApplicant:
            relationWithApplicant ?? this.relationWithApplicant,
        relationWithApplicantId:
            relationWithApplicantId ?? this.relationWithApplicantId,
        occupation: occupation ?? this.occupation,
        occupationId: occupationId ?? this.occupationId,
        annualIncome: annualIncome ?? this.annualIncome,
        id: id ?? this.id,
      );

  factory FamilyDataList.fromJson(Map<String, dynamic> json) => FamilyDataList(
        farmerId: json["farmerId"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        genderId: json["genderId"],
        relationWithApplicant: json["relationWithApplicant"],
        relationWithApplicantId: json["relationWithApplicantId"],
        occupation: json["occupation"],
        occupationId: json["occupationId"],
        annualIncome: json["annualIncome"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "farmerId": farmerId,
        "name": name,
        "age": age,
        "gender": gender,
        "genderId": genderId,
        "relationWithApplicant": relationWithApplicant,
        "relationWithApplicantId": relationWithApplicantId,
        "occupation": occupation,
        "occupationId": occupationId,
        "annualIncome": annualIncome,
        "id": id,
      };
}
