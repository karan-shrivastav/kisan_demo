// To parse this JSON data, do
//
//     final loanCountResponseModel = loanCountResponseModelFromJson(jsonString);

import 'dart:convert';

LoanCountResponseModel loanCountResponseModelFromJson(String str) =>
    LoanCountResponseModel.fromJson(json.decode(str));

String loanCountResponseModelToJson(LoanCountResponseModel data) =>
    json.encode(data.toJson());

class LoanCountResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataList>? dataList;

  LoanCountResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanCountResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataList>? dataList,
  }) =>
      LoanCountResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanCountResponseModel.fromJson(Map<String, dynamic> json) =>
      LoanCountResponseModel(
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
  String? statusName;
  int? totalCount;
  int? statusId;

  DataList({
    this.statusName,
    this.totalCount,
    this.statusId,
  });

  DataList copyWith({
    String? statusName,
    int? totalCount,
    int? statusId,
  }) =>
      DataList(
        statusName: statusName ?? this.statusName,
        totalCount: totalCount ?? this.totalCount,
        statusId: statusId ?? this.statusId,
      );

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        statusName: json["statusName"],
        totalCount: json["totalCount"],
        statusId: json["statusId"],
      );

  Map<String, dynamic> toJson() => {
        "statusName": statusName,
        "totalCount": totalCount,
        "statusId": statusId,
      };
}
