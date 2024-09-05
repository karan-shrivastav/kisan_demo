// To parse this JSON data, do
//
//     final addCropCubitModel = addCropCubitModelFromJson(jsonString);

import 'dart:convert';

AddCropCubitModel addCropCubitModelFromJson(String str) =>
    AddCropCubitModel.fromJson(json.decode(str));

String addCropCubitModelToJson(AddCropCubitModel data) =>
    json.encode(data.toJson());

class AddCropCubitModel {
  String? landTypeId;
  String? landTypeName;
  String? croppingSeasonId;
  String? croppingSeasonName;
  String? cropId;
  String? cropName;
  String? areaUnitName;
  String? areaUnitId;
  double? mainAmount;
  String? totalInAcer;
  String? landSize;

  AddCropCubitModel(
      {this.landTypeId,
      this.landTypeName,
      this.croppingSeasonId,
      this.croppingSeasonName,
      this.cropId,
      this.areaUnitName,
      this.areaUnitId,
      this.cropName,
      this.mainAmount,
      this.totalInAcer,
      this.landSize});

  AddCropCubitModel copyWith(
          {String? landTypeId,
          String? landTypeName,
          String? croppingSeasonId,
          String? croppingSeasonName,
          String? cropId,
          String? areaUnitName,
          String? areaUnitId,
          String? cropName,
          double? mainAmount,
          String? totalInAcer,
          String? landSize}) =>
      AddCropCubitModel(
          landTypeId: landTypeId ?? this.landTypeId,
          landTypeName: landTypeName ?? this.landTypeName,
          croppingSeasonId: croppingSeasonId ?? this.croppingSeasonId,
          croppingSeasonName: croppingSeasonName ?? this.croppingSeasonName,
          cropId: cropId ?? this.cropId,
          areaUnitName: areaUnitName ?? this.areaUnitName,
          areaUnitId: areaUnitId ?? this.areaUnitId,
          cropName: cropName ?? this.cropName,
          mainAmount: mainAmount ?? this.mainAmount,
          totalInAcer: totalInAcer ?? this.totalInAcer,
          landSize: landSize ?? this.landSize);

  factory AddCropCubitModel.fromJson(Map<String, dynamic> json) =>
      AddCropCubitModel(
          landTypeId: json["landTypeId"],
          landTypeName: json["landTypeName"],
          croppingSeasonId: json["croppingSeasonId"],
          croppingSeasonName: json["croppingSeasonName"],
          cropId: json["cropId"],
          areaUnitName: json["areaUnitName"],
          areaUnitId: json["areaUnitId"],
          cropName: json["cropName"],
          mainAmount: json["mainAmount"],
          totalInAcer: json["totalInAcer"],
          landSize: json["landSize"]);

  Map<String, dynamic> toJson() => {
        "landTypeId": landTypeId,
        "landTypeName": landTypeName,
        "croppingSeasonId": croppingSeasonId,
        "croppingSeasonName": croppingSeasonName,
        "cropId": cropId,
        "areaUnitName": areaUnitName,
        "areaUnitId": areaUnitId,
        "cropName": cropName,
        "mainAmount": mainAmount,
        "totalInAcer": totalInAcer,
        "landSize": landSize
      };
}
