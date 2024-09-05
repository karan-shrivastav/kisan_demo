// To parse this JSON data, do
//
//     final addLandIrrigatedNonIrrigatedCubitModel = addLandIrrigatedNonIrrigatedCubitModelFromJson(jsonString);

import 'dart:convert';

AddLandIrrigatedNonIrrigatedCubitModel
    addLandIrrigatedNonIrrigatedCubitModelFromJson(String str) =>
        AddLandIrrigatedNonIrrigatedCubitModel.fromJson(json.decode(str));

String addLandIrrigatedNonIrrigatedCubitModelToJson(
        AddLandIrrigatedNonIrrigatedCubitModel data) =>
    json.encode(data.toJson());

class AddLandIrrigatedNonIrrigatedCubitModel {
  String? irrigated;
  String? nonIrrigated;
  String? landSize;
  int? areaUnitId;
  int? sourceOfIrrigationId;

  AddLandIrrigatedNonIrrigatedCubitModel(
      {this.irrigated,
      this.nonIrrigated,
      this.landSize,
      this.areaUnitId,
      this.sourceOfIrrigationId});

  AddLandIrrigatedNonIrrigatedCubitModel copyWith(
          {String? irrigated,
          String? nonIrrigated,
          String? landSize,
          int? areaUnitId,
          int? sourceOfIrrigationId}) =>
      AddLandIrrigatedNonIrrigatedCubitModel(
          irrigated: irrigated ?? this.irrigated,
          nonIrrigated: nonIrrigated ?? this.nonIrrigated,
          landSize: landSize ?? this.landSize,
          areaUnitId: areaUnitId ?? this.areaUnitId,
          sourceOfIrrigationId: sourceOfIrrigationId ?? this.sourceOfIrrigationId);

  factory AddLandIrrigatedNonIrrigatedCubitModel.fromJson(
          Map<String, dynamic> json) =>
      AddLandIrrigatedNonIrrigatedCubitModel(
          irrigated: json["irrigated"],
          nonIrrigated: json["nonIrrigated"],
          landSize: json["landSize"],
          areaUnitId: json["areaUnitId"],
          sourceOfIrrigationId: json["sourceOfIrrigationId"]);

  Map<String, dynamic> toJson() => {
        "irrigated": irrigated,
        "nonIrrigated": nonIrrigated,
        "landSize": landSize,
        "areaUnitId": areaUnitId,
        "sourceOfIrrigationId": sourceOfIrrigationId
      };
}
