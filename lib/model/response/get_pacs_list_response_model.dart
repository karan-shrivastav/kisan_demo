// To parse this JSON data, do
//
//     final pacsListNewResponseModel = pacsListNewResponseModelFromJson(jsonString);

import 'dart:convert';

PacsListNewResponseModel pacsListNewResponseModelFromJson(String str) => PacsListNewResponseModel.fromJson(json.decode(str));

String pacsListNewResponseModelToJson(PacsListNewResponseModel data) => json.encode(data.toJson());

class PacsListNewResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<DataListNewOfPacs>? dataList;

  PacsListNewResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  PacsListNewResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<DataListNewOfPacs>? dataList,
  }) =>
      PacsListNewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory PacsListNewResponseModel.fromJson(Map<String, dynamic> json) => PacsListNewResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: List<DataListNewOfPacs>.from(json["dataList"].map((x) => DataListNewOfPacs.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class DataListNewOfPacs {
  int? pincode;
  dynamic city;
  int ?mobileNo;
  String ?firstName;
  String ?email;
  int? bankMasterId;
  int ?id;
  String ?middleName;
  dynamic ifscCode;
  String ?lastName;
  String ?entityLevelName;
  int? disctrictMasterId;
  int? stateMasterId;
  int ?organizationHierarchyId;
  String ?address;

  DataListNewOfPacs({
    this.pincode,
    this.city,
    this.mobileNo,
    this.firstName,
    this.email,
    this.bankMasterId,
    this.id,
    this.middleName,
    this.ifscCode,
    this.lastName,
    this.entityLevelName,
    this.disctrictMasterId,
    this.stateMasterId,
    this.organizationHierarchyId,
    this.address,
  });

  DataListNewOfPacs copyWith({
    int? pincode,
    dynamic city,
    int? mobileNo,
    String? firstName,
    String? email,
    int? bankMasterId,
    int? id,
    String? middleName,
    dynamic ifscCode,
    String? lastName,
    String? entityLevelName,
    int? disctrictMasterId,
    int? stateMasterId,
    int? organizationHierarchyId,
    String? address,
  }) =>
      DataListNewOfPacs(
        pincode: pincode ?? this.pincode,
        city: city ?? this.city,
        mobileNo: mobileNo ?? this.mobileNo,
        firstName: firstName ?? this.firstName,
        email: email ?? this.email,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        id: id ?? this.id,
        middleName: middleName ?? this.middleName,
        ifscCode: ifscCode ?? this.ifscCode,
        lastName: lastName ?? this.lastName,
        entityLevelName: entityLevelName ?? this.entityLevelName,
        disctrictMasterId: disctrictMasterId ?? this.disctrictMasterId,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        organizationHierarchyId: organizationHierarchyId ?? this.organizationHierarchyId,
        address: address ?? this.address,
      );

  factory DataListNewOfPacs.fromJson(Map<String, dynamic> json) => DataListNewOfPacs(
    pincode: json["pincode"],
    city: json["city"],
    mobileNo: json["mobile_no"],
    firstName: json["first_name"],
    email: json["email"],
    bankMasterId: json["bank_master_id"],
    id: json["id"],
    middleName: json["middle_name"],
    ifscCode: json["ifsc_code"],
    lastName: json["last_name"],
    entityLevelName: json["entity_level_name"],
    disctrictMasterId: json["disctrict_master_id"],
    stateMasterId: json["state_master_id"],
    organizationHierarchyId: json["organization_hierarchy_id"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "pincode": pincode,
    "city": city,
    "mobile_no": mobileNo,
    "first_name": firstName,
    "email": email,
    "bank_master_id": bankMasterId,
    "id": id,
    "middle_name": middleName,
    "ifsc_code": ifscCode,
    "last_name": lastName,
    "entity_level_name": entityLevelName,
    "disctrict_master_id": disctrictMasterId,
    "state_master_id": stateMasterId,
    "organization_hierarchy_id": organizationHierarchyId,
    "address": address,
  };
}
