// To parse this JSON data, do
//
//     final loanSubmitResponseModel = loanSubmitResponseModelFromJson(jsonString);

import 'dart:convert';

LoanSubmitResponseModel loanSubmitResponseModelFromJson(String str) => LoanSubmitResponseModel.fromJson(json.decode(str));

String loanSubmitResponseModelToJson(LoanSubmitResponseModel data) => json.encode(data.toJson());

class LoanSubmitResponseModel {
  int? status;
  String? message;
  dynamic data;
  dynamic dataList;

  LoanSubmitResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanSubmitResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    dynamic dataList,
  }) =>
      LoanSubmitResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanSubmitResponseModel.fromJson(Map<String, dynamic> json) => LoanSubmitResponseModel(
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
