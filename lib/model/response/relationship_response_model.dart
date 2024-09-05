// To parse this JSON data, do
//
//     final relationshipDataModel = relationshipDataModelFromJson(jsonString);

import 'dart:convert';

RelationshipDataModel relationshipDataModelFromJson(String str) =>
    RelationshipDataModel.fromJson(json.decode(str));

String relationshipDataModelToJson(RelationshipDataModel data) =>
    json.encode(data.toJson());

class RelationshipDataModel {
  int? status;
  String? message;
  dynamic data;
  List<RelationShipDataList>? dataList;

  RelationshipDataModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  RelationshipDataModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<RelationShipDataList>? dataList,
  }) =>
      RelationshipDataModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory RelationshipDataModel.fromJson(Map<String, dynamic> json) =>
      RelationshipDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: List<RelationShipDataList>.from(
            json["dataList"].map((x) => RelationShipDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class RelationShipDataList {
  String? valueBengali;
  String? lovType;
  String? valueKannada;
  dynamic valueAssamese;
  dynamic valueSanskrit;
  String? valueNepali;
  int? id;
  String? valueGujrati;
  String? valueMarathi;
  String? value;
  String? valueMalayalam;
  String? valueEnglish;
  String? parentvalue;
  String? valueTelugu;
  String? valueTamil;
  dynamic valueKashmiri;
  String? valueHindi;
  dynamic valueKonkani;
  dynamic valueCode;
  String? valuePanjabi;
  String? valueOrdia;
  String? valueUrdu;

  RelationShipDataList({
    this.valueBengali,
    this.lovType,
    this.valueKannada,
    this.valueAssamese,
    this.valueSanskrit,
    this.valueNepali,
    this.id,
    this.valueGujrati,
    this.valueMarathi,
    this.value,
    this.valueMalayalam,
    this.valueEnglish,
    this.parentvalue,
    this.valueTelugu,
    this.valueTamil,
    this.valueKashmiri,
    this.valueHindi,
    this.valueKonkani,
    this.valueCode,
    this.valuePanjabi,
    this.valueOrdia,
    this.valueUrdu,
  });

  RelationShipDataList copyWith({
    String? valueBengali,
    String? lovType,
    String? valueKannada,
    dynamic valueAssamese,
    dynamic valueSanskrit,
    String? valueNepali,
    int? id,
    String? valueGujrati,
    String? valueMarathi,
    String? value,
    String? valueMalayalam,
    String? valueEnglish,
    String? parentvalue,
    String? valueTelugu,
    String? valueTamil,
    dynamic valueKashmiri,
    String? valueHindi,
    dynamic valueKonkani,
    dynamic valueCode,
    String? valuePanjabi,
    String? valueOrdia,
    String? valueUrdu,
  }) =>
      RelationShipDataList(
        valueBengali: valueBengali ?? this.valueBengali,
        lovType: lovType ?? this.lovType,
        valueKannada: valueKannada ?? this.valueKannada,
        valueAssamese: valueAssamese ?? this.valueAssamese,
        valueSanskrit: valueSanskrit ?? this.valueSanskrit,
        valueNepali: valueNepali ?? this.valueNepali,
        id: id ?? this.id,
        valueGujrati: valueGujrati ?? this.valueGujrati,
        valueMarathi: valueMarathi ?? this.valueMarathi,
        value: value ?? this.value,
        valueMalayalam: valueMalayalam ?? this.valueMalayalam,
        valueEnglish: valueEnglish ?? this.valueEnglish,
        parentvalue: parentvalue ?? this.parentvalue,
        valueTelugu: valueTelugu ?? this.valueTelugu,
        valueTamil: valueTamil ?? this.valueTamil,
        valueKashmiri: valueKashmiri ?? this.valueKashmiri,
        valueHindi: valueHindi ?? this.valueHindi,
        valueKonkani: valueKonkani ?? this.valueKonkani,
        valueCode: valueCode ?? this.valueCode,
        valuePanjabi: valuePanjabi ?? this.valuePanjabi,
        valueOrdia: valueOrdia ?? this.valueOrdia,
        valueUrdu: valueUrdu ?? this.valueUrdu,
      );

  factory RelationShipDataList.fromJson(Map<String, dynamic> json) =>
      RelationShipDataList(
        valueBengali: json["value_bengali"],
        lovType: json["lov_type"],
        valueKannada: json["value_kannada"],
        valueAssamese: json["value_assamese"],
        valueSanskrit: json["value_sanskrit"],
        valueNepali: json["value_nepali"],
        id: json["id"],
        valueGujrati: json["value_gujrati"],
        valueMarathi: json["value_marathi"],
        value: json["value"],
        valueMalayalam: json["value_malayalam"],
        valueEnglish: json["value_english"],
        parentvalue: json["parentvalue"],
        valueTelugu: json["value_telugu"],
        valueTamil: json["value_tamil"],
        valueKashmiri: json["value_kashmiri"],
        valueHindi: json["value_hindi"],
        valueKonkani: json["value_konkani"],
        valueCode: json["value_code"],
        valuePanjabi: json["value_panjabi"],
        valueOrdia: json["value_ordia"],
        valueUrdu: json["value_urdu"],
      );

  Map<String, dynamic> toJson() => {
        "value_bengali": valueBengali,
        "lov_type": lovType,
        "value_kannada": valueKannada,
        "value_assamese": valueAssamese,
        "value_sanskrit": valueSanskrit,
        "value_nepali": valueNepali,
        "id": id,
        "value_gujrati": valueGujrati,
        "value_marathi": valueMarathi,
        "value": value,
        "value_malayalam": valueMalayalam,
        "value_english": valueEnglish,
        "parentvalue": parentvalue,
        "value_telugu": valueTelugu,
        "value_tamil": valueTamil,
        "value_kashmiri": valueKashmiri,
        "value_hindi": valueHindi,
        "value_konkani": valueKonkani,
        "value_code": valueCode,
        "value_panjabi": valuePanjabi,
        "value_ordia": valueOrdia,
        "value_urdu": valueUrdu,
      };
}
