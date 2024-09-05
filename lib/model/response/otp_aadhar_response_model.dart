// To parse this JSON data, do
//
//     final otpAadharResponseModel = otpAadharResponseModelFromJson(jsonString);

import 'dart:convert';

OtpAadharResponseModel otpAadharResponseModelFromJson(String str) => OtpAadharResponseModel.fromJson(json.decode(str));

String otpAadharResponseModelToJson(OtpAadharResponseModel data) => json.encode(data.toJson());

class OtpAadharResponseModel {
  int? status;
  String? message;
  String? data;
  dynamic dataList;

  OtpAadharResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  OtpAadharResponseModel copyWith({
    int? status,
    String? message,
    String? data,
    dynamic dataList,
  }) =>
      OtpAadharResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory OtpAadharResponseModel.fromJson(Map<String, dynamic> json) => OtpAadharResponseModel(
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
