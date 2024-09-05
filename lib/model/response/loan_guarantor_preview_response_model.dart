// To parse this JSON data, do
//
//     final loanNewDetailsResponseModel = loanNewDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

LoanNewDetailsResponseModel loanNewDetailsResponseModelFromJson(String str) =>
    LoanNewDetailsResponseModel.fromJson(json.decode(str));

String loanNewDetailsResponseModelToJson(LoanNewDetailsResponseModel data) =>
    json.encode(data.toJson());

class LoanNewDetailsResponseModel {
  dynamic status;
  String? message;
  Data? data;
  dynamic dataList;

  LoanNewDetailsResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanNewDetailsResponseModel copyWith({
    dynamic status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      LoanNewDetailsResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanNewDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      LoanNewDetailsResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        dataList: json["dataList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
    "dataList": dataList,
  };
}

class Data {
  List<LoanGuarantorMapper>? loanGuarantorMappers;
  List<LiablitiyGuarantorMapper>? liablitiyGuarantorMappers;
  List<UserLoanLiabilityLiabilitiesMapper>? userLoanLiabilityLiabilitiesMappers;

  Data({
    this.loanGuarantorMappers,
    this.liablitiyGuarantorMappers,
    this.userLoanLiabilityLiabilitiesMappers,
  });

  Data copyWith({
    List<LoanGuarantorMapper>? loanGuarantorMappers,
    List<LiablitiyGuarantorMapper>? liablitiyGuarantorMappers,
    List<UserLoanLiabilityLiabilitiesMapper>?
    userLoanLiabilityLiabilitiesMappers,
  }) =>
      Data(
        loanGuarantorMappers: loanGuarantorMappers ?? this.loanGuarantorMappers,
        liablitiyGuarantorMappers:
        liablitiyGuarantorMappers ?? this.liablitiyGuarantorMappers,
        userLoanLiabilityLiabilitiesMappers:
        userLoanLiabilityLiabilitiesMappers ??
            this.userLoanLiabilityLiabilitiesMappers,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    loanGuarantorMappers: List<LoanGuarantorMapper>.from(
        json["loanGuarantorMappers"]
            .map((x) => LoanGuarantorMapper.fromJson(x))),
    liablitiyGuarantorMappers: List<LiablitiyGuarantorMapper>.from(
        json["liablitiyGuarantorMappers"]
            .map((x) => LiablitiyGuarantorMapper.fromJson(x))),
    userLoanLiabilityLiabilitiesMappers:
    List<UserLoanLiabilityLiabilitiesMapper>.from(
        json["userLoanLiabilityLiabilitiesMappers"].map(
                (x) => UserLoanLiabilityLiabilitiesMapper.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "loanGuarantorMappers":
    List<dynamic>.from(loanGuarantorMappers!.map((x) => x.toJson())),
    "liablitiyGuarantorMappers": List<dynamic>.from(
        liablitiyGuarantorMappers!.map((x) => x.toJson())),
    "userLoanLiabilityLiabilitiesMappers": List<dynamic>.from(
        userLoanLiabilityLiabilitiesMappers!.map((x) => x.toJson())),
  };
}

class LiablitiyGuarantorMapper {
  dynamic id;
  String? bankName;
  dynamic bankMasterId;
  dynamic accountStatusId;
  dynamic loanMasterId;
  String? guarantorName;
  dynamic outstanding;
  String? bankType;
  dynamic loanAmount;
  String? accountStateName;

  LiablitiyGuarantorMapper({
    this.id,
    this.bankName,
    this.bankMasterId,
    this.accountStatusId,
    this.loanMasterId,
    this.guarantorName,
    this.outstanding,
    this.bankType,
    this.loanAmount,
    this.accountStateName,
  });

  LiablitiyGuarantorMapper copyWith({
    dynamic id,
    String? bankName,
    dynamic bankMasterId,
    dynamic accountStatusId,
    dynamic loanMasterId,
    String? guarantorName,
    dynamic outstanding,
    String? bankType,
    dynamic loanAmount,
    String? accountStateName,
  }) =>
      LiablitiyGuarantorMapper(
        id: id ?? this.id,
        bankName: bankName ?? this.bankName,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        accountStatusId: accountStatusId ?? this.accountStatusId,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        guarantorName: guarantorName ?? this.guarantorName,
        outstanding: outstanding ?? this.outstanding,
        bankType: bankType ?? this.bankType,
        loanAmount: loanAmount ?? this.loanAmount,
        accountStateName: accountStateName ?? this.accountStateName,
      );

  factory LiablitiyGuarantorMapper.fromJson(Map<String, dynamic> json) =>
      LiablitiyGuarantorMapper(
        id: json["id"],
        bankName: json["bankName"],
        bankMasterId: json["bankMasterId"],
        accountStatusId: json["accountStatusId"],
        loanMasterId: json["loanMasterId"],
        guarantorName: json["guarantorName"],
        outstanding: json["outstanding"],
        bankType: json["bankType"],
        loanAmount: json["loanAmount"],
        accountStateName: json["accountStateName"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bankName": bankName,
    "bankMasterId": bankMasterId,
    "accountStatusId": accountStatusId,
    "loanMasterId": loanMasterId,
    "guarantorName": guarantorName,
    "outstanding": outstanding,
    "bankType": bankType,
    "loanAmount": loanAmount,
    "accountStateName": accountStateName,
  };
}

class LoanGuarantorMapper {
  dynamic id;
  String? address;
  String? guarantorName;
  dynamic occupationDataId;
  dynamic age;
  String? mobileNumber;
  dynamic netWorth;
  dynamic loandMasterId;
  String? occupationName;

  LoanGuarantorMapper({
    this.id,
    this.address,
    this.guarantorName,
    this.occupationDataId,
    this.age,
    this.mobileNumber,
    this.netWorth,
    this.loandMasterId,
    this.occupationName,
  });

  LoanGuarantorMapper copyWith({
    dynamic id,
    String? address,
    String? guarantorName,
    dynamic occupationDataId,
    dynamic age,
    String? mobileNumber,
    dynamic netWorth,
    dynamic loandMasterId,
    String? occupationName,
  }) =>
      LoanGuarantorMapper(
        id: id ?? this.id,
        address: address ?? this.address,
        guarantorName: guarantorName ?? this.guarantorName,
        occupationDataId: occupationDataId ?? this.occupationDataId,
        age: age ?? this.age,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        netWorth: netWorth ?? this.netWorth,
        loandMasterId: loandMasterId ?? this.loandMasterId,
        occupationName: occupationName ?? this.occupationName,
      );

  factory LoanGuarantorMapper.fromJson(Map<String, dynamic> json) =>
      LoanGuarantorMapper(
        id: json["id"],
        address: json["address"],
        guarantorName: json["guarantorName"],
        occupationDataId: json["occupationDataId"],
        age: json["age"],
        mobileNumber: json["mobileNumber"],
        netWorth: json["netWorth"],
        loandMasterId: json["loandMasterId"],
        occupationName: json["occupationName"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "guarantorName": guarantorName,
    "occupationDataId": occupationDataId,
    "age": age,
    "mobileNumber": mobileNumber,
    "netWorth": netWorth,
    "loandMasterId": loandMasterId,
    "occupationName": occupationName,
  };
}

class UserLoanLiabilityLiabilitiesMapper {
  dynamic id;
  String? bankName;
  dynamic bankMasterId;
  dynamic accountStatusId;
  dynamic securityOfferedId;
  dynamic loanMasterId;
  dynamic farmerId;
  dynamic outstanding;
  String? branchName;
  String? bankType;
  String? loanPurpose;
  String? accountStatusName;
  String? securityOfferedName;

  UserLoanLiabilityLiabilitiesMapper({
    this.id,
    this.bankName,
    this.bankMasterId,
    this.accountStatusId,
    this.securityOfferedId,
    this.loanMasterId,
    this.farmerId,
    this.outstanding,
    this.branchName,
    this.bankType,
    this.loanPurpose,
    this.accountStatusName,
    this.securityOfferedName,
  });

  UserLoanLiabilityLiabilitiesMapper copyWith({
    dynamic id,
    String? bankName,
    dynamic bankMasterId,
    dynamic accountStatusId,
    dynamic securityOfferedId,
    dynamic loanMasterId,
    dynamic farmerId,
    dynamic outstanding,
    String? branchName,
    String? bankType,
    String? loanPurpose,
    String? accountStatusName,
    String? securityOfferedName,
  }) =>
      UserLoanLiabilityLiabilitiesMapper(
        id: id ?? this.id,
        bankName: bankName ?? this.bankName,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        accountStatusId: accountStatusId ?? this.accountStatusId,
        securityOfferedId: securityOfferedId ?? this.securityOfferedId,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        farmerId: farmerId ?? this.farmerId,
        outstanding: outstanding ?? this.outstanding,
        branchName: branchName ?? this.branchName,
        bankType: bankType ?? this.bankType,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        accountStatusName: accountStatusName ?? this.accountStatusName,
        securityOfferedName: securityOfferedName ?? this.securityOfferedName,
      );

  factory UserLoanLiabilityLiabilitiesMapper.fromJson(
      Map<String, dynamic> json) =>
      UserLoanLiabilityLiabilitiesMapper(
        id: json["id"],
        bankName: json["bankName"],
        bankMasterId: json["bankMasterId"],
        accountStatusId: json["accountStatusId"],
        securityOfferedId: json["securityOfferedId"],
        loanMasterId: json["loanMasterId"],
        farmerId: json["farmerId"],
        outstanding: json["outstanding"],
        branchName: json["branchName"],
        bankType: json["bankType"],
        loanPurpose: json["loanPurpose"],
        accountStatusName: json["accountStatusName"],
        securityOfferedName: json["securityOfferedName"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bankName": bankName,
    "bankMasterId": bankMasterId,
    "accountStatusId": accountStatusId,
    "securityOfferedId": securityOfferedId,
    "loanMasterId": loanMasterId,
    "farmerId": farmerId,
    "outstanding": outstanding,
    "branchName": branchName,
    "bankType": bankType,
    "loanPurpose": loanPurpose,
    "accountStatusName": accountStatusName,
    "securityOfferedName": securityOfferedName,
  };
}
