// To parse this JSON data, do
//
//     final getDistrictResponseModel = getDistrictResponseModelFromJson(jsonString);

import 'dart:convert';

GetDistrictResponseModel getDistrictResponseModelFromJson(String str) => GetDistrictResponseModel.fromJson(json.decode(str));

String getDistrictResponseModelToJson(GetDistrictResponseModel data) => json.encode(data.toJson());

class GetDistrictResponseModel {
  int ?status;
  String ?message;
  dynamic data;
  List<DataListDistrict> ?dataList;

  GetDistrictResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetDistrictResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataListDistrict>? dataList,
  }) =>
      GetDistrictResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetDistrictResponseModel.fromJson(Map<String, dynamic> json) => GetDistrictResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: List<DataListDistrict>.from(json["dataList"].map((x) => DataListDistrict.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class DataListDistrict {
  String? districtName;
  int ?stateMasterId;
  int ?id;
  dynamic countryCode;
  int ?districtCode;

  DataListDistrict({
    this.districtName,
    this.stateMasterId,
    this.id,
    this.countryCode,
    this.districtCode,
  });

  DataListDistrict copyWith({
    String? districtName,
    int? stateMasterId,
    int? id,
    dynamic countryCode,
    int? districtCode,
  }) =>
      DataListDistrict(
        districtName: districtName ?? this.districtName,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        id: id ?? this.id,
        countryCode: countryCode ?? this.countryCode,
        districtCode: districtCode ?? this.districtCode,
      );

  factory DataListDistrict.fromJson(Map<String, dynamic> json) => DataListDistrict(
    districtName: json["districtName"],
    stateMasterId: json["stateMasterId"],
    id: json["id"],
    countryCode: json["countryCode"],
    districtCode: json["districtCode"],
  );

  Map<String, dynamic> toJson() => {
    "districtName": districtName,
    "stateMasterId": stateMasterId,
    "id": id,
    "countryCode": countryCode,
    "districtCode": districtCode,
  };
}
