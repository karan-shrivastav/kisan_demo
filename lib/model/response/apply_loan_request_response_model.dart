// To parse this JSON data, do
//
//     final applyLoanRequestResponseModel = applyLoanRequestResponseModelFromJson(jsonString);

import 'dart:convert';

ApplyLoanRequestResponseModel applyLoanRequestResponseModelFromJson(String str) => ApplyLoanRequestResponseModel.fromJson(json.decode(str));

String applyLoanRequestResponseModelToJson(ApplyLoanRequestResponseModel data) => json.encode(data.toJson());

class ApplyLoanRequestResponseModel {
  int? status;
  String? message;
  dynamic data;
  dynamic dataList;

  ApplyLoanRequestResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  ApplyLoanRequestResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    dynamic dataList,
  }) =>
      ApplyLoanRequestResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory ApplyLoanRequestResponseModel.fromJson(Map<String, dynamic> json) => ApplyLoanRequestResponseModel(
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
