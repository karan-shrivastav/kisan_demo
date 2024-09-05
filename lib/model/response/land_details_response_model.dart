// To parse this JSON data, do
//
//     final getLandDetailsResponseModel = getLandDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

GetLandDetailsResponseModel getLandDetailsResponseModelFromJson(String str) => GetLandDetailsResponseModel.fromJson(json.decode(str));

String getLandDetailsResponseModelToJson(GetLandDetailsResponseModel data) => json.encode(data.toJson());

class GetLandDetailsResponseModel {
  int ?status;
  String ?message;
  Data ?data;
  dynamic dataList;

  GetLandDetailsResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetLandDetailsResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      GetLandDetailsResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetLandDetailsResponseModel.fromJson(Map<String, dynamic> json) => GetLandDetailsResponseModel(
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
  List<LandDataContent>? content;
  int? numberOfPages;
  dynamic numOfLedDistributed;
  int ?numberOfTotalElements;
  dynamic others;

  Data({
    this.content,
    this.numberOfPages,
    this.numOfLedDistributed,
    this.numberOfTotalElements,
    this.others,
  });

  Data copyWith({
    List<LandDataContent>? content,
    int? numberOfPages,
    dynamic numOfLedDistributed,
    int? numberOfTotalElements,
    dynamic others,
  }) =>
      Data(
        content: content ?? this.content,
        numberOfPages: numberOfPages ?? this.numberOfPages,
        numOfLedDistributed: numOfLedDistributed ?? this.numOfLedDistributed,
        numberOfTotalElements: numberOfTotalElements ?? this.numberOfTotalElements,
        others: others ?? this.others,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    content: List<LandDataContent>.from(json["content"].map((x) => LandDataContent.fromJson(x))),
    numberOfPages: json["numberOfPages"],
    numOfLedDistributed: json["numOfLedDistributed"],
    numberOfTotalElements: json["numberOfTotalElements"],
    others: json["others"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "numberOfPages": numberOfPages,
    "numOfLedDistributed": numOfLedDistributed,
    "numberOfTotalElements": numberOfTotalElements,
    "others": others,
  };
}

class LandDataContent {
  dynamic createdBy;
  DateTime? createdDate;
  dynamic lastModifiedBy;
  DateTime? lastModifiedDate;
  int? id;
  int ?farmerId;
  int ?villageId;
  AreaUnit ?ownership;
  int ?ownershipId;
  String ?ownershipName;
  AreaUnit? areaUnit;
  dynamic areaUnitId;
  String ?areaUnitName;
  AreaUnit? sourceOfIrrigation;
  dynamic sourceOfIrrigationId;
  String ?sourceOfIrrigationName;
  String ?surveyNo;
  String ?encumbered;
  dynamic area;
  dynamic irrigatedLand;
  dynamic unIrrigatedLand;
  dynamic farmId;
  dynamic landPdf;
  int ?isDeleted;
  dynamic ?hobliCode;
  dynamic talukNameKan;
  dynamic surnoc;
  dynamic hissano;
  dynamic areaHectare;
  dynamic publicLiablity;
  dynamic governmentLiablity;
  dynamic longitude;
  dynamic latitude;
  int ?stateMasterId;
  int ?districtMasterId;
  String ?villageName;
  String ?districtName;
  String ?stateName;
  bool ? isChecked;

  LandDataContent({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.farmerId,
    this.villageId,
    this.ownership,
    this.ownershipId,
    this.ownershipName,
    this.areaUnit,
    this.areaUnitId,
    this.areaUnitName,
    this.sourceOfIrrigation,
    this.sourceOfIrrigationId,
    this.sourceOfIrrigationName,
    this.surveyNo,
    this.encumbered,
    this.area,
    this.irrigatedLand,
    this.unIrrigatedLand,
    this.farmId,
    this.landPdf,
    this.isDeleted,
    this.hobliCode,
    this.talukNameKan,
    this.surnoc,
    this.hissano,
    this.areaHectare,
    this.publicLiablity,
    this.governmentLiablity,
    this.longitude,
    this.latitude,
    this.stateMasterId,
    this.districtMasterId,
    this.villageName,
    this.districtName,
    this.stateName,
    this.isChecked  = false
  });

  LandDataContent copyWith({
    dynamic createdBy,
    DateTime? createdDate,
    dynamic lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    int? farmerId,
    int? villageId,
    AreaUnit? ownership,
    int? ownershipId,
    String? ownershipName,
    AreaUnit? areaUnit,
    dynamic areaUnitId,
    String? areaUnitName,
    AreaUnit? sourceOfIrrigation,
    dynamic sourceOfIrrigationId,
    String? sourceOfIrrigationName,
    String? surveyNo,
    String? encumbered,
    dynamic area,
    dynamic irrigatedLand,
    double? unIrrigatedLand,
    dynamic farmId,
    dynamic landPdf,
    int? isDeleted,
    dynamic hobliCode,
    dynamic talukNameKan,
    dynamic surnoc,
    dynamic hissano,
    dynamic areaHectare,
    dynamic publicLiablity,
    dynamic governmentLiablity,
    dynamic longitude,
    dynamic latitude,
    int? stateMasterId,
    int? districtMasterId,
    String? villageName,
    String? districtName,
    String? stateName,
  }) =>
      LandDataContent(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        villageId: villageId ?? this.villageId,
        ownership: ownership ?? this.ownership,
        ownershipId: ownershipId ?? this.ownershipId,
        ownershipName: ownershipName ?? this.ownershipName,
        areaUnit: areaUnit ?? this.areaUnit,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        areaUnitName: areaUnitName ?? this.areaUnitName,
        sourceOfIrrigation: sourceOfIrrigation ?? this.sourceOfIrrigation,
        sourceOfIrrigationId: sourceOfIrrigationId ?? this.sourceOfIrrigationId,
        sourceOfIrrigationName: sourceOfIrrigationName ?? this.sourceOfIrrigationName,
        surveyNo: surveyNo ?? this.surveyNo,
        encumbered: encumbered ?? this.encumbered,
        area: area ?? this.area,
        irrigatedLand: irrigatedLand ?? this.irrigatedLand,
        unIrrigatedLand: unIrrigatedLand ?? this.unIrrigatedLand,
        farmId: farmId ?? this.farmId,
        landPdf: landPdf ?? this.landPdf,
        isDeleted: isDeleted ?? this.isDeleted,
        hobliCode: hobliCode ?? this.hobliCode,
        talukNameKan: talukNameKan ?? this.talukNameKan,
        surnoc: surnoc ?? this.surnoc,
        hissano: hissano ?? this.hissano,
        areaHectare: areaHectare ?? this.areaHectare,
        publicLiablity: publicLiablity ?? this.publicLiablity,
        governmentLiablity: governmentLiablity ?? this.governmentLiablity,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        villageName: villageName ?? this.villageName,
        districtName: districtName ?? this.districtName,
        stateName: stateName ?? this.stateName,
      );

  factory LandDataContent.fromJson(Map<String, dynamic> json) => LandDataContent(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    farmerId: json["farmerId"],
    villageId: json["villageId"],
    ownership: AreaUnit.fromJson(json["ownership"]),
    ownershipId: json["ownershipId"],
    ownershipName: json["ownershipName"],
    areaUnit: AreaUnit.fromJson(json["areaUnit"]),
    areaUnitId: json["areaUnitId"],
    areaUnitName: json["areaUnitName"],
    sourceOfIrrigation: AreaUnit.fromJson(json["sourceOfIrrigation"]),
    sourceOfIrrigationId: json["sourceOfIrrigationId"],
    sourceOfIrrigationName: json["sourceOfIrrigationName"],
    surveyNo: json["surveyNo"],
    encumbered: json["encumbered"],
    area: json["area"],
    irrigatedLand: json["irrigatedLand"],
    unIrrigatedLand: json["unIrrigatedLand"].toDouble(),
    farmId: json["farmId"],
    landPdf: json["landPdf"],
    isDeleted: json["isDeleted"],
    hobliCode: json["hobliCode"],
    talukNameKan: json["talukNameKan"],
    surnoc: json["surnoc"],
    hissano: json["hissano"],
    areaHectare: json["areaHectare"],
    publicLiablity: json["publicLiablity"],
    governmentLiablity: json["governmentLiablity"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    stateMasterId: json["stateMasterId"],
    districtMasterId: json["districtMasterId"],
    villageName: json["villageName"],
    districtName: json["districtName"],
    stateName: json["stateName"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "farmerId": farmerId,
    "villageId": villageId,
    "ownership": ownership?.toJson(),
    "ownershipId": ownershipId,
    "ownershipName": ownershipName,
    "areaUnit": areaUnit?.toJson(),
    "areaUnitId": areaUnitId,
    "areaUnitName": areaUnitName,
    "sourceOfIrrigation": sourceOfIrrigation?.toJson(),
    "sourceOfIrrigationId": sourceOfIrrigationId,
    "sourceOfIrrigationName": sourceOfIrrigationName,
    "surveyNo": surveyNo,
    "encumbered": encumbered,
    "area": area,
    "irrigatedLand": irrigatedLand,
    "unIrrigatedLand": unIrrigatedLand,
    "farmId": farmId,
    "landPdf": landPdf,
    "isDeleted": isDeleted,
    "hobliCode": hobliCode,
    "talukNameKan": talukNameKan,
    "surnoc": surnoc,
    "hissano": hissano,
    "areaHectare": areaHectare,
    "publicLiablity": publicLiablity,
    "governmentLiablity": governmentLiablity,
    "longitude": longitude,
    "latitude": latitude,
    "stateMasterId": stateMasterId,
    "districtMasterId": districtMasterId,
    "villageName": villageName,
    "districtName": districtName,
    "stateName": stateName,
  };
}

class AreaUnit {
  dynamic createdBy;
  DateTime? createdDate;
  dynamic lastModifiedBy;
  DateTime ?lastModifiedDate;
  int ?id;
  dynamic parLovType;
  dynamic lovType;
  String ?value;
  dynamic priority;
  int? isDeleted;
  dynamic comment;
  dynamic valueHindi;
  dynamic valueEnglish;
  dynamic valueGujrati;
  dynamic valueBengali;
  dynamic valuePanjabi;
  dynamic valueSanskrit;
  dynamic valueAssamese;
  dynamic valueKannada;
  dynamic valueKashmiri;
  dynamic valueKonkani;
  dynamic valueMalayalam;
  dynamic valueMarathi;
  dynamic valueNepali;
  dynamic valueOdia;
  dynamic valueTamil;
  dynamic valueTelugu;
  dynamic valueUrdu;
  dynamic valueCode;

  AreaUnit({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.parLovType,
    this.lovType,
    this.value,
    this.priority,
    this.isDeleted,
    this.comment,
    this.valueHindi,
    this.valueEnglish,
    this.valueGujrati,
    this.valueBengali,
    this.valuePanjabi,
    this.valueSanskrit,
    this.valueAssamese,
    this.valueKannada,
    this.valueKashmiri,
    this.valueKonkani,
    this.valueMalayalam,
    this.valueMarathi,
    this.valueNepali,
    this.valueOdia,
    this.valueTamil,
    this.valueTelugu,
    this.valueUrdu,
    this.valueCode,
  });

  AreaUnit copyWith({
    dynamic createdBy,
    DateTime? createdDate,
    dynamic lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    dynamic parLovType,
    dynamic lovType,
    String? value,
    dynamic priority,
    int? isDeleted,
    dynamic comment,
    dynamic valueHindi,
    dynamic valueEnglish,
    dynamic valueGujrati,
    dynamic valueBengali,
    dynamic valuePanjabi,
    dynamic valueSanskrit,
    dynamic valueAssamese,
    dynamic valueKannada,
    dynamic valueKashmiri,
    dynamic valueKonkani,
    dynamic valueMalayalam,
    dynamic valueMarathi,
    dynamic valueNepali,
    dynamic valueOdia,
    dynamic valueTamil,
    dynamic valueTelugu,
    dynamic valueUrdu,
    dynamic valueCode,
  }) =>
      AreaUnit(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        parLovType: parLovType ?? this.parLovType,
        lovType: lovType ?? this.lovType,
        value: value ?? this.value,
        priority: priority ?? this.priority,
        isDeleted: isDeleted ?? this.isDeleted,
        comment: comment ?? this.comment,
        valueHindi: valueHindi ?? this.valueHindi,
        valueEnglish: valueEnglish ?? this.valueEnglish,
        valueGujrati: valueGujrati ?? this.valueGujrati,
        valueBengali: valueBengali ?? this.valueBengali,
        valuePanjabi: valuePanjabi ?? this.valuePanjabi,
        valueSanskrit: valueSanskrit ?? this.valueSanskrit,
        valueAssamese: valueAssamese ?? this.valueAssamese,
        valueKannada: valueKannada ?? this.valueKannada,
        valueKashmiri: valueKashmiri ?? this.valueKashmiri,
        valueKonkani: valueKonkani ?? this.valueKonkani,
        valueMalayalam: valueMalayalam ?? this.valueMalayalam,
        valueMarathi: valueMarathi ?? this.valueMarathi,
        valueNepali: valueNepali ?? this.valueNepali,
        valueOdia: valueOdia ?? this.valueOdia,
        valueTamil: valueTamil ?? this.valueTamil,
        valueTelugu: valueTelugu ?? this.valueTelugu,
        valueUrdu: valueUrdu ?? this.valueUrdu,
        valueCode: valueCode ?? this.valueCode,
      );

  factory AreaUnit.fromJson(Map<String, dynamic> json) => AreaUnit(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    parLovType: json["parLovType"],
    lovType: json["lovType"],
    value: json["value"],
    priority: json["priority"],
    isDeleted: json["isDeleted"],
    comment: json["comment"],
    valueHindi: json["valueHindi"],
    valueEnglish: json["valueEnglish"],
    valueGujrati: json["valueGujrati"],
    valueBengali: json["valueBengali"],
    valuePanjabi: json["valuePanjabi"],
    valueSanskrit: json["valueSanskrit"],
    valueAssamese: json["valueAssamese"],
    valueKannada: json["valueKannada"],
    valueKashmiri: json["valueKashmiri"],
    valueKonkani: json["valueKonkani"],
    valueMalayalam: json["valueMalayalam"],
    valueMarathi: json["valueMarathi"],
    valueNepali: json["valueNepali"],
    valueOdia: json["valueOdia"],
    valueTamil: json["valueTamil"],
    valueTelugu: json["valueTelugu"],
    valueUrdu: json["valueUrdu"],
    valueCode: json["valueCode"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate!.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate!.toIso8601String(),
    "id": id,
    "parLovType": parLovType,
    "lovType": lovType,
    "value": value,
    "priority": priority,
    "isDeleted": isDeleted,
    "comment": comment,
    "valueHindi": valueHindi,
    "valueEnglish": valueEnglish,
    "valueGujrati": valueGujrati,
    "valueBengali": valueBengali,
    "valuePanjabi": valuePanjabi,
    "valueSanskrit": valueSanskrit,
    "valueAssamese": valueAssamese,
    "valueKannada": valueKannada,
    "valueKashmiri": valueKashmiri,
    "valueKonkani": valueKonkani,
    "valueMalayalam": valueMalayalam,
    "valueMarathi": valueMarathi,
    "valueNepali": valueNepali,
    "valueOdia": valueOdia,
    "valueTamil": valueTamil,
    "valueTelugu": valueTelugu,
    "valueUrdu": valueUrdu,
    "valueCode": valueCode,
  };
}
