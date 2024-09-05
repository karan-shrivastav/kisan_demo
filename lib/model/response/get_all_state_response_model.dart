// To parse this JSON data, do
//
//     final getAllStateResponseModel = getAllStateResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllStateResponseModel getAllStateResponseModelFromJson(String str) =>
    GetAllStateResponseModel.fromJson(json.decode(str));

String getAllStateResponseModelToJson(GetAllStateResponseModel data) =>
    json.encode(data.toJson());

class GetAllStateResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataStateList>? dataList;

  GetAllStateResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetAllStateResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataStateList>? dataList,
  }) =>
      GetAllStateResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetAllStateResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllStateResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: List<DataStateList>.from(
            json["dataList"].map((x) => DataStateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class DataStateList {
  String? stateName;
  String? countryCode;
  int? id;
  String? stateCode;

  DataStateList({
    this.stateName,
    this.countryCode,
    this.id,
    this.stateCode,
  });

  DataStateList copyWith({
    String? stateName,
    String? countryCode,
    int? id,
    String? stateCode,
  }) =>
      DataStateList(
        stateName: stateName ?? this.stateName,
        countryCode: countryCode ?? this.countryCode,
        id: id ?? this.id,
        stateCode: stateCode ?? this.stateCode,
      );

  factory DataStateList.fromJson(Map<String, dynamic> json) => DataStateList(
    stateName: json["stateName"],
    countryCode: json["countryCode"],
    id: json["id"],
    stateCode: json["stateCode"],
  );

  Map<String, dynamic> toJson() => {
    "stateName": stateName,
    "countryCode": countryCode,
    "id": id,
    "stateCode": stateCode,
  };
}
