// To parse this JSON data, do
//
//     final getBanksTypeTypeResponseModel = getBanksTypeTypeResponseModelFromJson(jsonString);

import 'dart:convert';

GetBanksTypeTypeResponseModel getBanksTypeTypeResponseModelFromJson(
        String str) =>
    GetBanksTypeTypeResponseModel.fromJson(json.decode(str));

String getBanksTypeTypeResponseModelToJson(
        GetBanksTypeTypeResponseModel data) =>
    json.encode(data.toJson());

class GetBanksTypeTypeResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataList>? dataList;

  GetBanksTypeTypeResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetBanksTypeTypeResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataList>? dataList,
  }) =>
      GetBanksTypeTypeResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetBanksTypeTypeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBanksTypeTypeResponseModel(
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
  dynamic createdDate;
  dynamic lastModifiedBy;
  dynamic lastModifiedDate;
  int? id;
  String? bankCode;
  String? bankName;
  String? bankType;
  dynamic stateMasterId;
  dynamic stateName;
  dynamic stateCode;
  dynamic districtMasterId;
  dynamic districtName;
  dynamic districtCode;

  DataList({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.bankCode,
    this.bankName,
    this.bankType,
    this.stateMasterId,
    this.stateName,
    this.stateCode,
    this.districtMasterId,
    this.districtName,
    this.districtCode,
  });

  DataList copyWith({
    String? createdBy,
    dynamic createdDate,
    dynamic lastModifiedBy,
    dynamic lastModifiedDate,
    int? id,
    String? bankCode,
    String? bankName,
    String? bankType,
    dynamic stateMasterId,
    dynamic stateName,
    dynamic stateCode,
    dynamic districtMasterId,
    dynamic districtName,
    dynamic districtCode,
  }) =>
      DataList(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,
        bankType: bankType ?? this.bankType,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        stateName: stateName ?? this.stateName,
        stateCode: stateCode ?? this.stateCode,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        districtName: districtName ?? this.districtName,
        districtCode: districtCode ?? this.districtCode,
      );

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"],
        id: json["id"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        bankType: json["bankType"],
        stateMasterId: json["stateMasterId"],
        stateName: json["stateName"],
        stateCode: json["stateCode"],
        districtMasterId: json["districtMasterId"],
        districtName: json["districtName"],
        districtCode: json["districtCode"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate,
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate,
        "id": id,
        "bankCode": bankCode,
        "bankName": bankName,
        "bankType": bankType,
        "stateMasterId": stateMasterId,
        "stateName": stateName,
        "stateCode": stateCode,
        "districtMasterId": districtMasterId,
        "districtName": districtName,
        "districtCode": districtCode,
      };
}
