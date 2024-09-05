// To parse this JSON data, do
//
//     final createFarmerAddressResponseModel = createFarmerAddressResponseModelFromJson(jsonString);

import 'dart:convert';

CreateFarmerAddressResponseModel createFarmerAddressResponseModelFromJson(String str) => CreateFarmerAddressResponseModel.fromJson(json.decode(str));

String createFarmerAddressResponseModelToJson(CreateFarmerAddressResponseModel data) => json.encode(data.toJson());

class CreateFarmerAddressResponseModel {
  int ?status;
  String? message;
  dynamic data;
  List<DataList>? dataList;

  CreateFarmerAddressResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  CreateFarmerAddressResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataList>? dataList,
  }) =>
      CreateFarmerAddressResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory CreateFarmerAddressResponseModel.fromJson(Map<String, dynamic> json) => CreateFarmerAddressResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: List<DataList>.from(json["dataList"].map((x) => DataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class DataList {
  int? id;
  int ?stateId;
  String? stateName;
  int ?districtId;
  String? districtName;
  String ?villageName;
  String ?address;
  String ?pincode;
  String ?addressType;
  int ?villageId;
  dynamic villageLocalName;

  DataList({
    this.id,
    this.stateId,
    this.stateName,
    this.districtId,
    this.districtName,
    this.villageName,
    this.address,
    this.pincode,
    this.addressType,
    this.villageId,
    this.villageLocalName,
  });

  DataList copyWith({
    int? id,
    int? stateId,
    String? stateName,
    int? districtId,
    String? districtName,
    String? villageName,
    String? address,
    String? pincode,
    String? addressType,
    int? villageId,
    dynamic villageLocalName,
  }) =>
      DataList(
        id: id ?? this.id,
        stateId: stateId ?? this.stateId,
        stateName: stateName ?? this.stateName,
        districtId: districtId ?? this.districtId,
        districtName: districtName ?? this.districtName,
        villageName: villageName ?? this.villageName,
        address: address ?? this.address,
        pincode: pincode ?? this.pincode,
        addressType: addressType ?? this.addressType,
        villageId: villageId ?? this.villageId,
        villageLocalName: villageLocalName ?? this.villageLocalName,
      );

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    id: json["id"],
    stateId: json["stateId"],
    stateName: json["stateName"],
    districtId: json["districtId"],
    districtName: json["districtName"],
    villageName: json["villageName"],
    address: json["address"],
    pincode: json["pincode"],
    addressType: json["addressType"],
    villageId: json["villageId"],
    villageLocalName: json["villageLocalName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateId": stateId,
    "stateName": stateName,
    "districtId": districtId,
    "districtName": districtName,
    "villageName": villageName,
    "address": address,
    "pincode": pincode,
    "addressType": addressType,
    "villageId": villageId,
    "villageLocalName": villageLocalName,
  };
}
