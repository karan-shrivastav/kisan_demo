// To parse this JSON data, do
//
//     final checkSideBarResponseModel = checkSideBarResponseModelFromJson(jsonString);

import 'dart:convert';

CheckSideBarResponseModel checkSideBarResponseModelFromJson(String str) => CheckSideBarResponseModel.fromJson(json.decode(str));

String checkSideBarResponseModelToJson(CheckSideBarResponseModel data) => json.encode(data.toJson());

class CheckSideBarResponseModel {
  int ?status;
  String ?message;
  Data ?data;
  dynamic dataList;

  CheckSideBarResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  CheckSideBarResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      CheckSideBarResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory CheckSideBarResponseModel.fromJson(Map<String, dynamic> json) => CheckSideBarResponseModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class Data {
  bool? viewLoan;
  bool ?viewJointApplicant;
  bool ?viewLandDetails;

  Data({
    this.viewLoan,
    this.viewJointApplicant,
    this.viewLandDetails,
  });

  Data copyWith({
    bool? viewLoan,
    bool? viewJointApplicant,
    bool? viewLandDetails,
  }) =>
      Data(
        viewLoan: viewLoan ?? this.viewLoan,
        viewJointApplicant: viewJointApplicant ?? this.viewJointApplicant,
        viewLandDetails: viewLandDetails ?? this.viewLandDetails,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    viewLoan: json["viewLoan"],
    viewJointApplicant: json["viewJointApplicant"],
    viewLandDetails: json["viewLandDetails"],
  );

  Map<String, dynamic> toJson() => {
    "viewLoan": viewLoan,
    "viewJointApplicant": viewJointApplicant,
    "viewLandDetails": viewLandDetails,
  };
}
