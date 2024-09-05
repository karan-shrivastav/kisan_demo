// To parse this JSON data, do
//
//     final getVillageResponseModel = getVillageResponseModelFromJson(jsonString);

import 'dart:convert';

GetVillageResponseModel getVillageResponseModelFromJson(String str) => GetVillageResponseModel.fromJson(json.decode(str));

String getVillageResponseModelToJson(GetVillageResponseModel data) => json.encode(data.toJson());

class GetVillageResponseModel {
  int ?status;
  String ?message;
  dynamic data;
  List<VillageDataLst>? dataList;

  GetVillageResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetVillageResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<VillageDataLst>? dataList,
  }) =>
      GetVillageResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetVillageResponseModel.fromJson(Map<String, dynamic> json) => GetVillageResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: List<VillageDataLst>.from(json["dataList"].map((x) => VillageDataLst.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class VillageDataLst {
  int ?id;
  int? districtMasterId;
  String ?villageName;
  int ?villageCode;

  VillageDataLst({
    this.id,
    this.districtMasterId,
    this.villageName,
    this.villageCode,
  });

  VillageDataLst copyWith({
    int? id,
    int? districtMasterId,
    String? villageName,
    int? villageCode,
  }) =>
      VillageDataLst(
        id: id ?? this.id,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        villageName: villageName ?? this.villageName,
        villageCode: villageCode ?? this.villageCode,
      );

  factory VillageDataLst.fromJson(Map<String, dynamic> json) => VillageDataLst(
    id: json["id"],
    districtMasterId: json["districtMasterId"],
    villageName: json["villageName"],
    villageCode: json["villageCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "districtMasterId": districtMasterId,
    "villageName": villageName,
    "villageCode": villageCode,
  };
}
