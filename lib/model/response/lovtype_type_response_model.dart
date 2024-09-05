// To parse this JSON data, do
//
//     final lovsTypeModel = lovsTypeModelFromJson(jsonString);

import 'dart:convert';

LovsTypeModel lovsTypeModelFromJson(String str) => LovsTypeModel.fromJson(json.decode(str));

String lovsTypeModelToJson(LovsTypeModel data) => json.encode(data.toJson());

class LovsTypeModel {
  int? status;
  String ?message;
  dynamic data;
  List<LovTypeDataList>? dataList;

  LovsTypeModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LovsTypeModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<LovTypeDataList>? dataList,
  }) =>
      LovsTypeModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LovsTypeModel.fromJson(Map<String, dynamic> json) => LovsTypeModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: List<LovTypeDataList>.from(json["dataList"].map((x) => LovTypeDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class LovTypeDataList {
  dynamic createdBy;
  dynamic createdDate;
  dynamic lastModifiedBy;
  dynamic lastModifiedDate;
  int? id;
  String? parLovType;
  String ?lovType;
  String ?value;
  dynamic priority;
  int? isDeleted;
  dynamic comment;
  String ?valueHindi;
  String ?valueEnglish;
  String ?valueGujrati;
  dynamic valueBengali;
  dynamic valuePanjabi;
  dynamic valueSanskrit;
  dynamic valueAssamese;
  String ?valueKannada;
  dynamic valueKashmiri;
  dynamic valueKonkani;
  dynamic valueMalayalam;
  dynamic valueMarathi;
  dynamic valueNepali;
  dynamic valueOdia;
  dynamic valueTamil;
  dynamic valueTelugu;
  dynamic valueUrdu;
  int ?valueCode;

  LovTypeDataList({
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

  LovTypeDataList copyWith({
    dynamic createdBy,
    dynamic createdDate,
    dynamic lastModifiedBy,
    dynamic lastModifiedDate,
    int? id,
    String? parLovType,
    String? lovType,
    String? value,
    dynamic priority,
    int? isDeleted,
    dynamic comment,
    String? valueHindi,
    String? valueEnglish,
    String? valueGujrati,
    dynamic valueBengali,
    dynamic valuePanjabi,
    dynamic valueSanskrit,
    dynamic valueAssamese,
    String? valueKannada,
    dynamic valueKashmiri,
    dynamic valueKonkani,
    dynamic valueMalayalam,
    dynamic valueMarathi,
    dynamic valueNepali,
    dynamic valueOdia,
    dynamic valueTamil,
    dynamic valueTelugu,
    dynamic valueUrdu,
    int? valueCode,
  }) =>
      LovTypeDataList(
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

  factory LovTypeDataList.fromJson(Map<String, dynamic> json) => LovTypeDataList(
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: json["lastModifiedDate"],
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
    "createdDate": createdDate,
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate,
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
