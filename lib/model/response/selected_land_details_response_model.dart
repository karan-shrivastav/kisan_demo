import 'dart:convert';

SelectedLandDetailsResponseModel selectedLandDetailsResponseModelFromJson(String str) => SelectedLandDetailsResponseModel.fromJson(json.decode(str));

String selectedLandDetailsResponseModelToJson(SelectedLandDetailsResponseModel data) => json.encode(data.toJson());

class SelectedLandDetailsResponseModel {
  int? status;
  String? message;
  SelectedLandDetailsData? data;
  dynamic dataList;

  SelectedLandDetailsResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  SelectedLandDetailsResponseModel copyWith({
    int? status,
    String? message,
    SelectedLandDetailsData? data,
    dynamic dataList,
  }) =>
      SelectedLandDetailsResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory SelectedLandDetailsResponseModel.fromJson(Map<String, dynamic> json) => SelectedLandDetailsResponseModel(
    status: json["status"],
    message: json["message"],
    data: SelectedLandDetailsData.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class SelectedLandDetailsData {
  String? areaUnit;
  int? areaUnitId;
  dynamic totalLandArea;
  dynamic totalLandAreaInAcres;
  dynamic presentMarketValue;
  List<DetailDto>? detailDtos;
  dynamic totalIrrigatedLand;
  dynamic totalUnIrrigatedLand;

  SelectedLandDetailsData({
    this.areaUnit,
    this.areaUnitId,
    this.totalLandArea,
    this.totalLandAreaInAcres,
    this.presentMarketValue,
    this.detailDtos,
    this.totalIrrigatedLand,
    this.totalUnIrrigatedLand,
  });

  SelectedLandDetailsData copyWith({
    String? areaUnit,
    int? areaUnitId,
    dynamic totalLandArea,
    dynamic totalLandAreaInAcres,
    dynamic presentMarketValue,
    List<DetailDto>? detailDtos,
    dynamic totalIrrigatedLand,
    dynamic totalUnIrrigatedLand,
  }) =>
      SelectedLandDetailsData(
        areaUnit: areaUnit ?? this.areaUnit,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        totalLandArea: totalLandArea ?? this.totalLandArea,
        totalLandAreaInAcres: totalLandAreaInAcres ?? this.totalLandAreaInAcres,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        detailDtos: detailDtos ?? this.detailDtos,
        totalIrrigatedLand: totalIrrigatedLand ?? this.totalIrrigatedLand,
        totalUnIrrigatedLand: totalUnIrrigatedLand ?? this.totalUnIrrigatedLand,
      );

  factory SelectedLandDetailsData.fromJson(Map<String, dynamic> json) => SelectedLandDetailsData(
    areaUnit: json["areaUnit"],
    areaUnitId: json["areaUnitId"],
    totalLandArea: json["totalLandArea"],
    totalLandAreaInAcres: json["totalLandAreaInAcres"],
    presentMarketValue: json["presentMarketValue"],
    detailDtos: List<DetailDto>.from(json["detailDtos"].map((x) => DetailDto.fromJson(x))),
    totalIrrigatedLand: json["totalIrrigatedLand"],
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
  dynamic area;
  String? villageName;
  String? surveyNo;
  String? ownershipName;
  String? sourceOfIrrigationName;
  dynamic landTypeValue;
  String? encumbered;
  int? villageId;
  int? sourceOfIrrigationId;
  int? ownershipId;
  String? districtName;
  int? areaUnitId;
  dynamic irrigatedLand;
  dynamic unIrrigatedLand;
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
    this.villageId,
    this.sourceOfIrrigationId,
    this.ownershipId,
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
    dynamic area,
    String? villageName,
    String? surveyNo,
    String? ownershipName,
    String? sourceOfIrrigationName,
    dynamic landTypeValue,
    String? encumbered,
    int? villageId,
    int? sourceOfIrrigationId,
    int? ownershipId,
    String? districtName,
    int? areaUnitId,
    dynamic irrigatedLand,
    dynamic unIrrigatedLand,
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
        sourceOfIrrigationName: sourceOfIrrigationName ?? this.sourceOfIrrigationName,
        landTypeValue: landTypeValue ?? this.landTypeValue,
        encumbered: encumbered ?? this.encumbered,
        villageId: villageId ?? this.villageId,
        sourceOfIrrigationId: sourceOfIrrigationId ?? this.sourceOfIrrigationId,
        ownershipId: ownershipId ?? this.ownershipId,
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
    landTypeValue: json["landTypeValue"],
    encumbered: json["encumbered"],
    villageId: json["villageId"],
    sourceOfIrrigationId: json["sourceOfIrrigationId"],
    ownershipId: json["ownershipId"],
    districtName: json["districtName"],
    areaUnitId: json["areaUnitId"],
    irrigatedLand: json["irrigatedLand"],
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
    "villageId": villageId,
    "sourceOfIrrigationId": sourceOfIrrigationId,
    "ownershipId": ownershipId,
    "districtName": districtName,
    "areaUnitId": areaUnitId,
    "irrigatedLand": irrigatedLand,
    "unIrrigatedLand": unIrrigatedLand,
    "areaUnitName": areaUnitName,
  };
}
