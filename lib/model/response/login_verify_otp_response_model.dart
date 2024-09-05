// To parse this JSON data, do
//
//     final loginVerifyOtpResponseModel = loginVerifyOtpResponseModelFromJson(jsonString);

import 'dart:convert';

LoginVerifyOtpResponseModel loginVerifyOtpResponseModelFromJson(String str) => LoginVerifyOtpResponseModel.fromJson(json.decode(str));

String loginVerifyOtpResponseModelToJson(LoginVerifyOtpResponseModel data) => json.encode(data.toJson());

class LoginVerifyOtpResponseModel {
  int ?status;
  String ?message;
  Data ?data;
  dynamic dataList;

  LoginVerifyOtpResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoginVerifyOtpResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      LoginVerifyOtpResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoginVerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => LoginVerifyOtpResponseModel(
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
  dynamic userEmail;
  int ?userId;
  String ?role;
  int ?roleId;
  String ?userName;
  List<dynamic>? lastLoginList;
  dynamic orgnisationId;
  bool ?farmerRegistered;
  String ?idToken;
  String ?refreshToken;

  Data({
    this.userEmail,
    this.userId,
    this.role,
    this.roleId,
    this.userName,
    this.lastLoginList,
    this.orgnisationId,
    this.farmerRegistered,
    this.idToken,
    this.refreshToken,
  });

  Data copyWith({
    dynamic userEmail,
    int? userId,
    String? role,
    int? roleId,
    String? userName,
    List<dynamic>? lastLoginList,
    dynamic orgnisationId,
    bool? farmerRegistered,
    String? idToken,
    String? refreshToken,
  }) =>
      Data(
        userEmail: userEmail ?? this.userEmail,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        roleId: roleId ?? this.roleId,
        userName: userName ?? this.userName,
        lastLoginList: lastLoginList ?? this.lastLoginList,
        orgnisationId: orgnisationId ?? this.orgnisationId,
        farmerRegistered: farmerRegistered ?? this.farmerRegistered,
        idToken: idToken ?? this.idToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userEmail: json["userEmail"],
    userId: json["userId"],
    role: json["role"],
    roleId: json["roleId"],
    userName: json["userName"],
    lastLoginList: List<dynamic>.from(json["lastLoginList"].map((x) => x)),
    orgnisationId: json["orgnisationId"],
    farmerRegistered: json["farmerRegistered"],
    idToken: json["id_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "userEmail": userEmail,
    "userId": userId,
    "role": role,
    "roleId": roleId,
    "userName": userName,
    "lastLoginList": List<dynamic>.from(lastLoginList!.map((x) => x)),
    "orgnisationId": orgnisationId,
    "farmerRegistered": farmerRegistered,
    "id_token": idToken,
    "refresh_token": refreshToken,
  };
}
