// To parse this JSON data, do
//
//     final addLandCubitModel = addLandCubitModelFromJson(jsonString);

import 'dart:convert';

AddLandCubitModel addLandCubitModelFromJson(String str) =>
    AddLandCubitModel.fromJson(json.decode(str));

String addLandCubitModelToJson(AddLandCubitModel data) =>
    json.encode(data.toJson());

class AddLandCubitModel {
  int? farmerId;
  int? stateMasterId;
  int? districtMasterId;
  int? villageId;
  int? ownershipId;
  int? areaUnitId;
  int? sourceOfIrrigationId;
  String? surveyNo;
  String? encumbered;
  String? area;
  String? irrigatedLand;
  int? unIrrigatedLand;

  AddLandCubitModel({
    this.farmerId,
    this.stateMasterId,
    this.districtMasterId,
    this.villageId,
    this.ownershipId,
    this.areaUnitId,
    this.sourceOfIrrigationId,
    this.surveyNo,
    this.encumbered,
    this.area,
    this.irrigatedLand,
    this.unIrrigatedLand,
  });

  AddLandCubitModel copyWith({
    int? farmerId,
    int? stateMasterId,
    int? districtMasterId,
    int? villageId,
    int? ownershipId,
    int? areaUnitId,
    int? sourceOfIrrigationId,
    String? surveyNo,
    String? encumbered,
    String? area,
    String? irrigatedLand,
    int? unIrrigatedLand,
  }) =>
      AddLandCubitModel(
        farmerId: farmerId ?? this.farmerId,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        villageId: villageId ?? this.villageId,
        ownershipId: ownershipId ?? this.ownershipId,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        sourceOfIrrigationId: sourceOfIrrigationId ?? this.sourceOfIrrigationId,
        surveyNo: surveyNo ?? this.surveyNo,
        encumbered: encumbered ?? this.encumbered,
        area: area ?? this.area,
        irrigatedLand: irrigatedLand ?? this.irrigatedLand,
        unIrrigatedLand: unIrrigatedLand ?? this.unIrrigatedLand,
      );

  factory AddLandCubitModel.fromJson(Map<String, dynamic> json) =>
      AddLandCubitModel(
        farmerId: json["farmerId"],
        stateMasterId: json["stateMasterId"],
        districtMasterId: json["districtMasterId"],
        villageId: json["villageId"],
        ownershipId: json["ownershipId"],
        areaUnitId: json["areaUnitId"],
        sourceOfIrrigationId: json["sourceOfIrrigationId"],
        surveyNo: json["surveyNo"],
        encumbered: json["encumbered"],
        area: json["area"],
        irrigatedLand: json["irrigatedLand"],
        unIrrigatedLand: json["unIrrigatedLand"],
      );

  Map<String, dynamic> toJson() => {
        "farmerId": farmerId,
        "stateMasterId": stateMasterId,
        "districtMasterId": districtMasterId,
        "villageId": villageId,
        "ownershipId": ownershipId,
        "areaUnitId": areaUnitId,
        "sourceOfIrrigationId": sourceOfIrrigationId,
        "surveyNo": surveyNo,
        "encumbered": encumbered,
        "area": area,
        "irrigatedLand": irrigatedLand,
        "unIrrigatedLand": unIrrigatedLand,
      };
}
