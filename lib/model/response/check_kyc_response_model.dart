// To parse this JSON data, do
//
//     final checkKycResponseModel = checkKycResponseModelFromJson(jsonString);

import 'dart:convert';

CheckKycResponseModel checkKycResponseModelFromJson(String str) =>
    CheckKycResponseModel.fromJson(json.decode(str));

String checkKycResponseModelToJson(CheckKycResponseModel data) =>
    json.encode(data.toJson());

class CheckKycResponseModel {
  int? status;
  String? message;
  Data? data;
  dynamic dataList;

  CheckKycResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  CheckKycResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      CheckKycResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory CheckKycResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckKycResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        dataList: json["dataList"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
        "dataList": dataList,
      };
}

class Data {
  bool? farmerUpdate;
  bool? kyc;

  Data({
    this.farmerUpdate,
    this.kyc,
  });

  Data copyWith({
    bool? farmerUpdate,
    bool? kyc,
  }) =>
      Data(
        farmerUpdate: farmerUpdate ?? this.farmerUpdate,
        kyc: kyc ?? this.kyc,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        farmerUpdate: json["farmer_update"],
        kyc: json["kyc"],
      );

  Map<String, dynamic> toJson() => {
        "farmer_update": farmerUpdate,
        "kyc": kyc,
      };
}
