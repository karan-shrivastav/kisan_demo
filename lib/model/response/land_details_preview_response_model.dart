// To parse this JSON data, do
//
//     final landDetailsNewPreviewResponseModel = landDetailsNewPreviewResponseModelFromJson(jsonString);

import 'dart:convert';

LandDetailsNewPreviewResponseModel landDetailsNewPreviewResponseModelFromJson(
        String str) =>
    LandDetailsNewPreviewResponseModel.fromJson(json.decode(str));

String landDetailsNewPreviewResponseModelToJson(
        LandDetailsNewPreviewResponseModel data) =>
    json.encode(data.toJson());

class LandDetailsNewPreviewResponseModel {
  int? status;
  String? message;
  Data? data;
  dynamic dataList;

  LandDetailsNewPreviewResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LandDetailsNewPreviewResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      LandDetailsNewPreviewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LandDetailsNewPreviewResponseModel.fromJson(
          Map<String, dynamic> json) =>
      LandDetailsNewPreviewResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        dataList: json["dataList"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "dataList": dataList,
      };
}

class Data {
  String? areaUnit;
  int? areaUnitId;
  double? totalLandArea;
  double? totalLandAreaInAcres;
  double? presentMarketValue;
  List<DetailDto>? detailDtos;
  double? totalIrrigatedLand;
  double? totalUnIrrigatedLand;

  Data({
    this.areaUnit,
    this.areaUnitId,
    this.totalLandArea,
    this.totalLandAreaInAcres,
    this.presentMarketValue,
    this.detailDtos,
    this.totalIrrigatedLand,
    this.totalUnIrrigatedLand,
  });

  Data copyWith({
    String? areaUnit,
    int? areaUnitId,
    double? totalLandArea,
    double? totalLandAreaInAcres,
    double? presentMarketValue,
    List<DetailDto>? detailDtos,
    double? totalIrrigatedLand,
    double? totalUnIrrigatedLand,
  }) =>
      Data(
        areaUnit: areaUnit ?? this.areaUnit,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        totalLandArea: totalLandArea ?? this.totalLandArea,
        totalLandAreaInAcres: totalLandAreaInAcres ?? this.totalLandAreaInAcres,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        detailDtos: detailDtos ?? this.detailDtos,
        totalIrrigatedLand: totalIrrigatedLand ?? this.totalIrrigatedLand,
        totalUnIrrigatedLand: totalUnIrrigatedLand ?? this.totalUnIrrigatedLand,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        areaUnit: json["areaUnit"],
        areaUnitId: json["areaUnitId"],
        totalLandArea: json["totalLandArea"].toDouble(),
        totalLandAreaInAcres: json["totalLandAreaInAcres"].toDouble(),
        presentMarketValue: json["presentMarketValue"],
        detailDtos: List<DetailDto>.from(
            json["detailDtos"].map((x) => DetailDto.fromJson(x))),
        totalIrrigatedLand: json["totalIrrigatedLand"].toDouble(),
        totalUnIrrigatedLand: json["totalUnIrrigatedLand"],
      );

  Map<String, dynamic> toJson() => {
        "areaUnit": areaUnit,
        "areaUnitId": areaUnitId,
        "totalLandArea": totalLandArea,
        "totalLandAreaInAcres": totalLandAreaInAcres,
        "presentMarketValue": presentMarketValue,
        "detailDtos": List<dynamic>.from(detailDtos!.map((x) => x.toJson())),
        "totalIrrigatedLand": totalIrrigatedLand,
        "totalUnIrrigatedLand": totalUnIrrigatedLand,
      };
}

class DetailDto {
  int? id;
  String? stateName;
  int? stateId;
  int? districtId;
  double? area;
  String? villageName;
  String? surveyNo;
  String? ownershipName;
  String? sourceOfIrrigationName;
  double? landTypeValue;
  String? encumbered;
  int? ownershipId;
  int? villageId;
  int? sourceOfIrrigationId;
  String? districtName;
  int? areaUnitId;
  double? irrigatedLand;
  double? unIrrigatedLand;
  String? areaUnitName;

  DetailDto({
    this.id,
    this.stateName,
    this.stateId,
    this.districtId,
    this.area,
    this.villageName,
    this.surveyNo,
    this.ownershipName,
    this.sourceOfIrrigationName,
    this.landTypeValue,
    this.encumbered,
    this.ownershipId,
    this.villageId,
    this.sourceOfIrrigationId,
    this.districtName,
    this.areaUnitId,
    this.irrigatedLand,
    this.unIrrigatedLand,
    this.areaUnitName,
  });

  DetailDto copyWith({
    int? id,
    String? stateName,
    int? stateId,
    int? districtId,
    double? area,
    String? villageName,
    String? surveyNo,
    String? ownershipName,
    String? sourceOfIrrigationName,
    double? landTypeValue,
    String? encumbered,
    int? ownershipId,
    int? villageId,
    int? sourceOfIrrigationId,
    String? districtName,
    int? areaUnitId,
    double? irrigatedLand,
    double? unIrrigatedLand,
    String? areaUnitName,
  }) =>
      DetailDto(
        id: id ?? this.id,
        stateName: stateName ?? this.stateName,
        stateId: stateId ?? this.stateId,
        districtId: districtId ?? this.districtId,
        area: area ?? this.area,
        villageName: villageName ?? this.villageName,
        surveyNo: surveyNo ?? this.surveyNo,
        ownershipName: ownershipName ?? this.ownershipName,
        sourceOfIrrigationName:
            sourceOfIrrigationName ?? this.sourceOfIrrigationName,
        landTypeValue: landTypeValue ?? this.landTypeValue,
        encumbered: encumbered ?? this.encumbered,
        ownershipId: ownershipId ?? this.ownershipId,
        villageId: villageId ?? this.villageId,
        sourceOfIrrigationId: sourceOfIrrigationId ?? this.sourceOfIrrigationId,
        districtName: districtName ?? this.districtName,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        irrigatedLand: irrigatedLand ?? this.irrigatedLand,
        unIrrigatedLand: unIrrigatedLand ?? this.unIrrigatedLand,
        areaUnitName: areaUnitName ?? this.areaUnitName,
      );

  factory DetailDto.fromJson(Map<String, dynamic> json) => DetailDto(
        id: json["id"],
        stateName: json["stateName"],
        stateId: json["stateId"],
        districtId: json["districtId"],
        area: json["area"],
        villageName: json["villageName"],
        surveyNo: json["surveyNo"],
        ownershipName: json["ownershipName"],
        sourceOfIrrigationName: json["sourceOfIrrigationName"],
        landTypeValue: json["landTypeValue"].toDouble(),
        encumbered: json["encumbered"],
        ownershipId: json["ownershipId"],
        villageId: json["villageId"],
        sourceOfIrrigationId: json["sourceOfIrrigationId"],
        districtName: json["districtName"],
        areaUnitId: json["areaUnitId"],
        irrigatedLand: json["irrigatedLand"].toDouble(),
        unIrrigatedLand: json["unIrrigatedLand"],
        areaUnitName: json["areaUnitName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stateName": stateName,
        "stateId": stateId,
        "districtId": districtId,
        "area": area,
        "villageName": villageName,
        "surveyNo": surveyNo,
        "ownershipName": ownershipName,
        "sourceOfIrrigationName": sourceOfIrrigationName,
        "landTypeValue": landTypeValue,
        "encumbered": encumbered,
        "ownershipId": ownershipId,
        "villageId": villageId,
        "sourceOfIrrigationId": sourceOfIrrigationId,
        "districtName": districtName,
        "areaUnitId": areaUnitId,
        "irrigatedLand": irrigatedLand,
        "unIrrigatedLand": unIrrigatedLand,
        "areaUnitName": areaUnitName,
      };
}
