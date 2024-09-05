// To parse this JSON data, do
//
//     final addNewCropCubitModel = addNewCropCubitModelFromJson(jsonString);

import 'dart:convert';

List<AddNewCropCubitModel> addNewCropCubitModelFromJson(String str) =>
    List<AddNewCropCubitModel>.from(
        json.decode(str).map((x) => AddNewCropCubitModel.fromJson(x)));

String addNewCropCubitModelToJson(List<AddNewCropCubitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddNewCropCubitModel {
  String? landTypeId;
  String? landTypeName;
  String? croppingSeasonId;
  String? croppingSeasonName;
  String? cropId;
  String? cropName;
  String? areaUnitName;
  String? areaUnitId;
  double? mainAmount;
  String? totalInAcre;
  String? area;

  AddNewCropCubitModel({
    this.landTypeId,
    this.landTypeName,
    this.croppingSeasonId,
    this.croppingSeasonName,
    this.cropId,
    this.areaUnitName,
    this.areaUnitId,
    this.cropName,
    this.mainAmount,
    this.totalInAcre,
    this.area,
  });

  AddNewCropCubitModel copyWith({
    String? landTypeId,
    String? landTypeName,
    String? croppingSeasonId,
    String? croppingSeasonName,
    String? cropId,
    String? areaUnitName,
    String? areaUnitId,
    String? cropName,
    double? mainAmount,
    String? totalInAcre,
    String? area,
  }) =>
      AddNewCropCubitModel(
        landTypeId: landTypeId ?? this.landTypeId,
        landTypeName: landTypeName ?? this.landTypeName,
        croppingSeasonId: croppingSeasonId ?? this.croppingSeasonId,
        croppingSeasonName: croppingSeasonName ?? this.croppingSeasonName,
        cropId: cropId ?? this.cropId,
        areaUnitName: areaUnitName ?? this.areaUnitName,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        cropName: cropName ?? this.cropName,
        mainAmount: mainAmount ?? this.mainAmount,
        totalInAcre: totalInAcre ?? this.totalInAcre,
        area: area ?? this.area,
      );

  factory AddNewCropCubitModel.fromJson(Map<String, dynamic> json) =>
      AddNewCropCubitModel(
        landTypeId: json["landTypeId"],
        landTypeName: json["landTypeName"],
        croppingSeasonId: json["croppingSeasonId"],
        croppingSeasonName: json["croppingSeasonName"],
        cropId: json["cropId"],
        areaUnitName: json["areaUnitName"],
        areaUnitId: json["areaUnitId"],
        cropName: json["cropName"],
        mainAmount: json["mainAmount"],
        totalInAcre: json["totalInAcre"],
        area: json["area"],
      );

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
        "totalInAcre": totalInAcre,
        "area": area
      };
}
