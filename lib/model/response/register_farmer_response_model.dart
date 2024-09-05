// To parse this JSON data, do
//
//     final registerFarmerResponseModel = registerFarmerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterFarmerResponseModel registerFarmerResponseModelFromJson(String str) =>
    RegisterFarmerResponseModel.fromJson(json.decode(str));

String registerFarmerResponseModelToJson(RegisterFarmerResponseModel data) =>
    json.encode(data.toJson());

class RegisterFarmerResponseModel {
  int? status;
  String? message;
  dynamic data;
  dynamic dataList;

  RegisterFarmerResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  RegisterFarmerResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    dynamic dataList,
  }) =>
      RegisterFarmerResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory RegisterFarmerResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterFarmerResponseModel(
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
