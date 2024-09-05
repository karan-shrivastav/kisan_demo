// To parse this JSON data, do
//
//     final getAllBankTypeResponseModel = getAllBankTypeResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllBankTypeResponseModel getAllBankTypeResponseModelFromJson(String str) =>
    GetAllBankTypeResponseModel.fromJson(json.decode(str));

String getAllBankTypeResponseModelToJson(GetAllBankTypeResponseModel data) =>
    json.encode(data.toJson());

class GetAllBankTypeResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataList>? dataList;

  GetAllBankTypeResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetAllBankTypeResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataList>? dataList,
  }) =>
      GetAllBankTypeResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetAllBankTypeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllBankTypeResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: List<DataList>.from(
            json["dataList"].map((x) => DataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class DataList {
  String? value;
  String? name;

  DataList({
    this.value,
    this.name,
  });

  DataList copyWith({
    String? value,
    String? name,
  }) =>
      DataList(
        value: value ?? this.value,
        name: name ?? this.name,
      );

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        value: json["value"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };
}
