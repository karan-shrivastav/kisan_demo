// To parse this JSON data, do
//
//     final getCropNameListResponseModel = getCropNameListResponseModelFromJson(jsonString);

import 'dart:convert';

GetCropNameListResponseModel getCropNameListResponseModelFromJson(String str) =>
    GetCropNameListResponseModel.fromJson(json.decode(str));

String getCropNameListResponseModelToJson(GetCropNameListResponseModel data) =>
    json.encode(data.toJson());

class GetCropNameListResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataListOfCropName>? dataList;

  GetCropNameListResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetCropNameListResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataListOfCropName>? dataList,
  }) =>
      GetCropNameListResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetCropNameListResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCropNameListResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: List<DataListOfCropName>.from(
            json["dataList"].map((x) => DataListOfCropName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class DataListOfCropName {
  int? id;
  int? stateId;
  dynamic stateCode;
  dynamic stateName;
  int? districtId;
  String? districtCode;
  dynamic districtName;
  int? bankMasterId;
  int? agroclimaticZoneId;
  dynamic agroclimaticZoneName;
  int? landTypeId;
  dynamic landTypeName;
  int? areaUnitTypeId;
  dynamic areaUnitName;
  int? cropTypeId;
  dynamic cropTypeName;
  int? cropSeasonId;
  dynamic cropSeasonName;
  String? cropName;
  String? cropNameInLocal;
  double ? sofCropPrice;
  double? areaOfUnit;
  DateTime? financialYearStartDate;
  DateTime? financialYearEndDate;
  dynamic cropNameMultiLangId;
  dynamic hindi;
  dynamic english;
  dynamic gujrati;
  dynamic bengali;
  dynamic panjabi;
  dynamic sanskrit;
  dynamic assamese;
  dynamic kannada;
  dynamic kashmiri;
  dynamic konkani;
  dynamic malayalam;
  dynamic marathi;
  dynamic nepali;
  dynamic odia;
  dynamic tamil;
  dynamic telugu;
  dynamic urdu;

  DataListOfCropName({
    this.id,
    this.stateId,
    this.stateCode,
    this.stateName,
    this.districtId,
    this.districtCode,
    this.districtName,
    this.bankMasterId,
    this.agroclimaticZoneId,
    this.agroclimaticZoneName,
    this.landTypeId,
    this.landTypeName,
    this.areaUnitTypeId,
    this.areaUnitName,
    this.cropTypeId,
    this.cropTypeName,
    this.cropSeasonId,
    this.cropSeasonName,
    this.cropName,
    this.cropNameInLocal,
    this.sofCropPrice,
    this.areaOfUnit,
    this.financialYearStartDate,
    this.financialYearEndDate,
    this.cropNameMultiLangId,
    this.hindi,
    this.english,
    this.gujrati,
    this.bengali,
    this.panjabi,
    this.sanskrit,
    this.assamese,
    this.kannada,
    this.kashmiri,
    this.konkani,
    this.malayalam,
    this.marathi,
    this.nepali,
    this.odia,
    this.tamil,
    this.telugu,
    this.urdu,
  });

  DataListOfCropName copyWith({
    int? id,
    int? stateId,
    dynamic stateCode,
    dynamic stateName,
    int? districtId,
    String? districtCode,
    dynamic districtName,
    int? bankMasterId,
    int? agroclimaticZoneId,
    dynamic agroclimaticZoneName,
    int? landTypeId,
    dynamic landTypeName,
    int? areaUnitTypeId,
    dynamic areaUnitName,
    int? cropTypeId,
    dynamic cropTypeName,
    int? cropSeasonId,
    dynamic cropSeasonName,
    String? cropName,
    String? cropNameInLocal,
    double? sofCropPrice,
    double? areaOfUnit,
    DateTime? financialYearStartDate,
    DateTime? financialYearEndDate,
    dynamic cropNameMultiLangId,
    dynamic hindi,
    dynamic english,
    dynamic gujrati,
    dynamic bengali,
    dynamic panjabi,
    dynamic sanskrit,
    dynamic assamese,
    dynamic kannada,
    dynamic kashmiri,
    dynamic konkani,
    dynamic malayalam,
    dynamic marathi,
    dynamic nepali,
    dynamic odia,
    dynamic tamil,
    dynamic telugu,
    dynamic urdu,
  }) =>
      DataListOfCropName(
        id: id ?? this.id,
        stateId: stateId ?? this.stateId,
        stateCode: stateCode ?? this.stateCode,
        stateName: stateName ?? this.stateName,
        districtId: districtId ?? this.districtId,
        districtCode: districtCode ?? this.districtCode,
        districtName: districtName ?? this.districtName,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        agroclimaticZoneId: agroclimaticZoneId ?? this.agroclimaticZoneId,
        agroclimaticZoneName: agroclimaticZoneName ?? this.agroclimaticZoneName,
        landTypeId: landTypeId ?? this.landTypeId,
        landTypeName: landTypeName ?? this.landTypeName,
        areaUnitTypeId: areaUnitTypeId ?? this.areaUnitTypeId,
        areaUnitName: areaUnitName ?? this.areaUnitName,
        cropTypeId: cropTypeId ?? this.cropTypeId,
        cropTypeName: cropTypeName ?? this.cropTypeName,
        cropSeasonId: cropSeasonId ?? this.cropSeasonId,
        cropSeasonName: cropSeasonName ?? this.cropSeasonName,
        cropName: cropName ?? this.cropName,
        cropNameInLocal: cropNameInLocal ?? this.cropNameInLocal,
        sofCropPrice: sofCropPrice ?? this.sofCropPrice,
        areaOfUnit: areaOfUnit ?? this.areaOfUnit,
        financialYearStartDate:
        financialYearStartDate ?? this.financialYearStartDate,
        financialYearEndDate: financialYearEndDate ?? this.financialYearEndDate,
        cropNameMultiLangId: cropNameMultiLangId ?? this.cropNameMultiLangId,
        hindi: hindi ?? this.hindi,
        english: english ?? this.english,
        gujrati: gujrati ?? this.gujrati,
        bengali: bengali ?? this.bengali,
        panjabi: panjabi ?? this.panjabi,
        sanskrit: sanskrit ?? this.sanskrit,
        assamese: assamese ?? this.assamese,
        kannada: kannada ?? this.kannada,
        kashmiri: kashmiri ?? this.kashmiri,
        konkani: konkani ?? this.konkani,
        malayalam: malayalam ?? this.malayalam,
        marathi: marathi ?? this.marathi,
        nepali: nepali ?? this.nepali,
        odia: odia ?? this.odia,
        tamil: tamil ?? this.tamil,
        telugu: telugu ?? this.telugu,
        urdu: urdu ?? this.urdu,
      );

  factory DataListOfCropName.fromJson(Map<String, dynamic> json) =>
      DataListOfCropName(
        id: json["id"],
        stateId: json["stateId"],
        stateCode: json["stateCode"],
        stateName: json["stateName"],
        districtId: json["districtId"],
        districtCode: json["districtCode"],
        districtName: json["districtName"],
        bankMasterId: json["bankMasterId"],
        agroclimaticZoneId: json["agroclimaticZoneId"],
        agroclimaticZoneName: json["agroclimaticZoneName"],
        landTypeId: json["landTypeId"],
        landTypeName: json["landTypeName"],
        areaUnitTypeId: json["areaUnitTypeId"],
        areaUnitName: json["areaUnitName"],
        cropTypeId: json["cropTypeId"],
        cropTypeName: json["cropTypeName"],
        cropSeasonId: json["cropSeasonId"],
        cropSeasonName: json["cropSeasonName"],
        cropName: json["cropName"],
        cropNameInLocal: json["cropNameInLocal"],
        sofCropPrice: json["sofCropPrice"],
        areaOfUnit: json["areaOfUnit"],
        financialYearStartDate: DateTime.parse(json["financialYearStartDate"]),
        financialYearEndDate: DateTime.parse(json["financialYearEndDate"]),
        cropNameMultiLangId: json["cropNameMultiLangId"],
        hindi: json["hindi"],
        english: json["english"],
        gujrati: json["gujrati"],
        bengali: json["bengali"],
        panjabi: json["panjabi"],
        sanskrit: json["sanskrit"],
        assamese: json["assamese"],
        kannada: json["kannada"],
        kashmiri: json["kashmiri"],
        konkani: json["konkani"],
        malayalam: json["malayalam"],
        marathi: json["marathi"],
        nepali: json["nepali"],
        odia: json["odia"],
        tamil: json["tamil"],
        telugu: json["telugu"],
        urdu: json["urdu"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateId": stateId,
    "stateCode": stateCode,
    "stateName": stateName,
    "districtId": districtId,
    "districtCode": districtCode,
    "districtName": districtName,
    "bankMasterId": bankMasterId,
    "agroclimaticZoneId": agroclimaticZoneId,
    "agroclimaticZoneName": agroclimaticZoneName,
    "landTypeId": landTypeId,
    "landTypeName": landTypeName,
    "areaUnitTypeId": areaUnitTypeId,
    "areaUnitName": areaUnitName,
    "cropTypeId": cropTypeId,
    "cropTypeName": cropTypeName,
    "cropSeasonId": cropSeasonId,
    "cropSeasonName": cropSeasonName,
    "cropName": cropName,
    "cropNameInLocal": cropNameInLocal,
    "sofCropPrice": sofCropPrice,
    "areaOfUnit": areaOfUnit,
    "financialYearStartDate":
    "${financialYearStartDate!.year.toString().padLeft(4, '0')}-${financialYearStartDate!.month.toString().padLeft(2, '0')}-${financialYearStartDate!.day.toString().padLeft(2, '0')}",
    "financialYearEndDate":
    "${financialYearEndDate!.year.toString().padLeft(4, '0')}-${financialYearEndDate!.month.toString().padLeft(2, '0')}-${financialYearEndDate!.day.toString().padLeft(2, '0')}",
    "cropNameMultiLangId": cropNameMultiLangId,
    "hindi": hindi,
    "english": english,
    "gujrati": gujrati,
    "bengali": bengali,
    "panjabi": panjabi,
    "sanskrit": sanskrit,
    "assamese": assamese,
    "kannada": kannada,
    "kashmiri": kashmiri,
    "konkani": konkani,
    "malayalam": malayalam,
    "marathi": marathi,
    "nepali": nepali,
    "odia": odia,
    "tamil": tamil,
    "telugu": telugu,
    "urdu": urdu,
  };
}
