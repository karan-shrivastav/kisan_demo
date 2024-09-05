// To parse this JSON data, do
//
//     final saveLoanDetailsNewResponseModel = saveLoanDetailsNewResponseModelFromJson(jsonString);

import 'dart:convert';

SaveLoanDetailsNewResponseModel saveLoanDetailsNewResponseModelFromJson(
    String str) =>
    SaveLoanDetailsNewResponseModel.fromJson(json.decode(str));

String saveLoanDetailsNewResponseModelToJson(
    SaveLoanDetailsNewResponseModel data) =>
    json.encode(data.toJson());

class SaveLoanDetailsNewResponseModel {
  int? status;
  String? message;
  dynamic data;
  dynamic dataList;

  SaveLoanDetailsNewResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  SaveLoanDetailsNewResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    dynamic dataList,
  }) =>
      SaveLoanDetailsNewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory SaveLoanDetailsNewResponseModel.fromJson(Map<String, dynamic> json) =>
      SaveLoanDetailsNewResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: json["dataList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": dataList,
  };
}
