// To parse this JSON data, do
//
//     final addLandCubitModel = addLandCubitModelFromJson(jsonString);

import 'dart:convert';

EditLandCubitModel editLandCubitModelFromJson(String str) =>
    EditLandCubitModel.fromJson(json.decode(str));

String editLandCubitModelToJson(EditLandCubitModel data) =>
    json.encode(data.toJson());

class EditLandCubitModel {
  int ? id;
  int? farmerId;
  int? stateMasterId;
  String? stateName;
  int? districtMasterId;
  String? districtName;
  int? villageId;
  String? villageName;
  int? ownershipId;
  String? ownerShipName;
  int? areaUnitId;
  String? areaUnitName;
  int? sourceOfIrrigationId;
  String? sourceOfIrrigationNAme;
  String? surveyNo;
  String? encumbered;
  dynamic area;
  dynamic irrigatedLand;
  dynamic unIrrigatedLand;

  EditLandCubitModel({
    this.id,
    this.farmerId,
    this.stateMasterId,
    this.stateName,
    this.districtMasterId,
    this.districtName,
    this.villageId,
    this.villageName,
    this.ownershipId,
    this.ownerShipName,
    this.areaUnitId,
    this.areaUnitName,
    this.sourceOfIrrigationId,
    this.sourceOfIrrigationNAme,
    this.surveyNo,
    this.encumbered,
    this.area,
    this.irrigatedLand,
    this.unIrrigatedLand,
  });

  EditLandCubitModel copyWith({
    int? id,
    int? farmerId,
    int? stateMasterId,
    String? stateName,
    int? districtMasterId,
    String? districtName,
    int? villageId,
    String? villageName,
    int? ownershipId,
    String? ownerShipName,
    int? areaUnitId,
    String? areaUnitName,
    int? sourceOfIrrigationId,
    String? sourceOfIrrigationNAme,
    String? surveyNo,
    String? encumbered,
    dynamic area,
    dynamic irrigatedLand,
    dynamic unIrrigatedLand,
  }) =>
      EditLandCubitModel(
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        stateName: stateName ?? this.stateName,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        districtName: districtName ?? this.districtName,
        villageId: villageId ?? this.villageId,
        villageName: villageName ?? this.villageName,
        ownershipId: ownershipId ?? this.ownershipId,
        ownerShipName: ownerShipName ?? this.ownerShipName,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        areaUnitName: areaUnitName ?? this.areaUnitName,
        sourceOfIrrigationId: sourceOfIrrigationId ?? this.sourceOfIrrigationId,
        sourceOfIrrigationNAme:
        sourceOfIrrigationNAme ?? this.sourceOfIrrigationNAme,
        surveyNo: surveyNo ?? this.surveyNo,
        encumbered: encumbered ?? this.encumbered,
        area: area ?? this.area,
        irrigatedLand: irrigatedLand ?? this.irrigatedLand,
        unIrrigatedLand: unIrrigatedLand ?? this.unIrrigatedLand,
      );

  factory EditLandCubitModel.fromJson(Map<String, dynamic> json) =>
      EditLandCubitModel(
        id: json["id"],
        farmerId: json["farmerId"],
        stateMasterId: json["stateMasterId"],
        stateName: json["stateName"],
        districtMasterId: json["districtMasterId"],
        districtName: json["districtName"],
        villageId: json["villageId"],
        villageName: json["villageName"],
        ownershipId: json["ownershipId"],
        ownerShipName: json["ownerShipName"],
        areaUnitId: json["areaUnitId"],
        areaUnitName: json["areaUnitName"],
        sourceOfIrrigationId: json["sourceOfIrrigationId"],
        sourceOfIrrigationNAme: json["sourceOfIrrigationNAme"],
        surveyNo: json["surveyNo"],
        encumbered: json["encumbered"],
        area: json["area"],
        irrigatedLand: json["irrigatedLand"],
        unIrrigatedLand: json["unIrrigatedLand"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "farmerId": farmerId,
        "stateMasterId": stateMasterId,
        "stateName": stateName,
        "districtMasterId": districtMasterId,
        "districtName": districtName,
        "villageId": villageId,
        "villageName": villageName,
        "ownershipId": ownershipId,
        "ownerShipName": ownerShipName,
        "areaUnitId": areaUnitId,
        "areaUnitName": areaUnitName,
        "sourceOfIrrigationId": sourceOfIrrigationId,
        "sourceOfIrrigationNAme": sourceOfIrrigationNAme,
        "surveyNo": surveyNo,
        "encumbered": encumbered,
        "area": area,
        "irrigatedLand": irrigatedLand,
        "unIrrigatedLand": unIrrigatedLand,
      };
}
