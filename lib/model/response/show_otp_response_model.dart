// To parse this JSON data, do
//
//     final showOtpResponseModel = showOtpResponseModelFromJson(jsonString);

import 'dart:convert';

ShowOtpResponseModel showOtpResponseModelFromJson(String str) =>
    ShowOtpResponseModel.fromJson(json.decode(str));

String showOtpResponseModelToJson(ShowOtpResponseModel data) =>
    json.encode(data.toJson());

class ShowOtpResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataList>? dataList;

  ShowOtpResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  ShowOtpResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataList>? dataList,
  }) =>
      ShowOtpResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory ShowOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowOtpResponseModel(
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
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  int? id;
  dynamic email;
  String? code;
  DateTime? expiry;
  bool? used;
  String? type;
  int? mobileNo;
  int? otpAttempts;
  dynamic userId;

  DataList({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.email,
    this.code,
    this.expiry,
    this.used,
    this.type,
    this.mobileNo,
    this.otpAttempts,
    this.userId,
  });

  DataList copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    dynamic email,
    String? code,
    DateTime? expiry,
    bool? used,
    String? type,
    int? mobileNo,
    int? otpAttempts,
    dynamic userId,
  }) =>
      DataList(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        email: email ?? this.email,
        code: code ?? this.code,
        expiry: expiry ?? this.expiry,
        used: used ?? this.used,
        type: type ?? this.type,
        mobileNo: mobileNo ?? this.mobileNo,
        otpAttempts: otpAttempts ?? this.otpAttempts,
        userId: userId ?? this.userId,
      );

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        email: json["email"],
        code: json["code"],
        expiry: DateTime.parse(json["expiry"]),
        used: json["used"],
        type: json["type"],
        mobileNo: json["mobileNo"],
        otpAttempts: json["otpAttempts"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "email": email,
        "code": code,
        "expiry": expiry?.toIso8601String(),
        "used": used,
        "type": type,
        "mobileNo": mobileNo,
        "otpAttempts": otpAttempts,
        "userId": userId,
      };
}
