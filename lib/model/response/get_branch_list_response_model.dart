// To parse this JSON data, do
//
//     final branchListResponseModel = branchListResponseModelFromJson(jsonString);

import 'dart:convert';

BranchListResponseModel branchListResponseModelFromJson(String str) => BranchListResponseModel.fromJson(json.decode(str));

String branchListResponseModelToJson(BranchListResponseModel data) => json.encode(data.toJson());

class BranchListResponseModel {
  int ?status;
  String? message;
  dynamic data;
  List<DataList> ?dataList;

  BranchListResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  BranchListResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataList>? dataList,
  }) =>
      BranchListResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory BranchListResponseModel.fromJson(Map<String, dynamic> json) => BranchListResponseModel(
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
  String ?createdBy;
  DateTime ?createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  int ?id;
  String ?entityLevelCode;
  String ?entityLevelName;
  String ?address;
  int? pincode;
  String ?ifscCode;
  dynamic city;
  String ?bankLevelName;
  dynamic parentEntityLevel;
  int? parentEntityLevelId;
  dynamic stateMaster;
  int ?stateMasterId;
  dynamic stateName;
  dynamic districtMaster;
  int ?districtMasterId;
  dynamic districtName;
  dynamic bankMaster;
  int? bankMasterId;
  dynamic organizationHierarchy;
  int ?organizationHierarchyId;
  dynamic pacsDetail;
  dynamic pacsDetailId;

  DataList({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.entityLevelCode,
    this.entityLevelName,
    this.address,
    this.pincode,
    this.ifscCode,
    this.city,
    this.bankLevelName,
    this.parentEntityLevel,
    this.parentEntityLevelId,
    this.stateMaster,
    this.stateMasterId,
    this.stateName,
    this.districtMaster,
    this.districtMasterId,
    this.districtName,
    this.bankMaster,
    this.bankMasterId,
    this.organizationHierarchy,
    this.organizationHierarchyId,
    this.pacsDetail,
    this.pacsDetailId,
  });

  DataList copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    String? entityLevelCode,
    String? entityLevelName,
    String? address,
    int? pincode,
    String? ifscCode,
    dynamic city,
    String? bankLevelName,
    dynamic parentEntityLevel,
    int? parentEntityLevelId,
    dynamic stateMaster,
    int? stateMasterId,
    dynamic stateName,
    dynamic districtMaster,
    int? districtMasterId,
    dynamic districtName,
    dynamic bankMaster,
    int? bankMasterId,
    dynamic organizationHierarchy,
    int? organizationHierarchyId,
    dynamic pacsDetail,
    dynamic pacsDetailId,
  }) =>
      DataList(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        entityLevelCode: entityLevelCode ?? this.entityLevelCode,
        entityLevelName: entityLevelName ?? this.entityLevelName,
        address: address ?? this.address,
        pincode: pincode ?? this.pincode,
        ifscCode: ifscCode ?? this.ifscCode,
        city: city ?? this.city,
        bankLevelName: bankLevelName ?? this.bankLevelName,
        parentEntityLevel: parentEntityLevel ?? this.parentEntityLevel,
        parentEntityLevelId: parentEntityLevelId ?? this.parentEntityLevelId,
        stateMaster: stateMaster ?? this.stateMaster,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        stateName: stateName ?? this.stateName,
        districtMaster: districtMaster ?? this.districtMaster,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        districtName: districtName ?? this.districtName,
        bankMaster: bankMaster ?? this.bankMaster,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        organizationHierarchy: organizationHierarchy ?? this.organizationHierarchy,
        organizationHierarchyId: organizationHierarchyId ?? this.organizationHierarchyId,
        pacsDetail: pacsDetail ?? this.pacsDetail,
        pacsDetailId: pacsDetailId ?? this.pacsDetailId,
      );

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    entityLevelCode: json["entityLevelCode"],
    entityLevelName: json["entityLevelName"],
    address: json["address"],
    pincode: json["pincode"],
    ifscCode: json["ifscCode"],
    city: json["city"],
    bankLevelName: json["bankLevelName"],
    parentEntityLevel: json["parentEntityLevel"],
    parentEntityLevelId: json["parentEntityLevelId"],
    stateMaster: json["stateMaster"],
    stateMasterId: json["stateMasterId"],
    stateName: json["stateName"],
    districtMaster: json["districtMaster"],
    districtMasterId: json["districtMasterId"],
    districtName: json["districtName"],
    bankMaster: json["bankMaster"],
    bankMasterId: json["bankMasterId"],
    organizationHierarchy: json["organizationHierarchy"],
    organizationHierarchyId: json["organizationHierarchyId"],
    pacsDetail: json["pacsDetail"],
    pacsDetailId: json["pacsDetailId"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate!.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate!.toIso8601String(),
    "id": id,
    "entityLevelCode": entityLevelCode,
    "entityLevelName": entityLevelName,
    "address": address,
    "pincode": pincode,
    "ifscCode": ifscCode,
    "city": city,
    "bankLevelName": bankLevelName,
    "parentEntityLevel": parentEntityLevel,
    "parentEntityLevelId": parentEntityLevelId,
    "stateMaster": stateMaster,
    "stateMasterId": stateMasterId,
    "stateName": stateName,
    "districtMaster": districtMaster,
    "districtMasterId": districtMasterId,
    "districtName": districtName,
    "bankMaster": bankMaster,
    "bankMasterId": bankMasterId,
    "organizationHierarchy": organizationHierarchy,
    "organizationHierarchyId": organizationHierarchyId,
    "pacsDetail": pacsDetail,
    "pacsDetailId": pacsDetailId,
  };
}
