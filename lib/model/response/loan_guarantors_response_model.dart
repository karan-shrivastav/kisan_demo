import 'dart:convert';

LoanGuarantorResponseModel loanGuarantorResponseModelFromJson(String str) => LoanGuarantorResponseModel.fromJson(json.decode(str));

String loanGuarantorResponseModelToJson(LoanGuarantorResponseModel data) => json.encode(data.toJson());

class LoanGuarantorResponseModel {
  int? status;
  String? message;
  LoanGuarantorData? data;
  dynamic dataList;

  LoanGuarantorResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanGuarantorResponseModel copyWith({
    int? status,
    String? message,
    LoanGuarantorData? data,
    dynamic dataList,
  }) =>
      LoanGuarantorResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanGuarantorResponseModel.fromJson(Map<String, dynamic> json) => LoanGuarantorResponseModel(
    status: json["status"],
    message: json["message"],
    data: LoanGuarantorData.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class LoanGuarantorData {
  List<LoanGuarantorMapper>? loanGuarantorMappers;
  List<LiablitiyGuarantorMapper>? liablitiyGuarantorMappers;
  List<UserLoanLiabilityLiabilitiesMapper>? userLoanLiabilityLiabilitiesMappers;

  LoanGuarantorData({
    this.loanGuarantorMappers,
    this.liablitiyGuarantorMappers,
    this.userLoanLiabilityLiabilitiesMappers,
  });

  LoanGuarantorData copyWith({
    List<LoanGuarantorMapper>? loanGuarantorMappers,
    List<LiablitiyGuarantorMapper>? liablitiyGuarantorMappers,
    List<UserLoanLiabilityLiabilitiesMapper>? userLoanLiabilityLiabilitiesMappers,
  }) =>
      LoanGuarantorData(
        loanGuarantorMappers: loanGuarantorMappers ?? this.loanGuarantorMappers,
        liablitiyGuarantorMappers: liablitiyGuarantorMappers ?? this.liablitiyGuarantorMappers,
        userLoanLiabilityLiabilitiesMappers: userLoanLiabilityLiabilitiesMappers ?? this.userLoanLiabilityLiabilitiesMappers,
      );

  factory LoanGuarantorData.fromJson(Map<String, dynamic> json) => LoanGuarantorData(
    loanGuarantorMappers: List<LoanGuarantorMapper>.from(json["loanGuarantorMappers"].map((x) => LoanGuarantorMapper.fromJson(x))),
    liablitiyGuarantorMappers: List<LiablitiyGuarantorMapper>.from(json["liablitiyGuarantorMappers"].map((x) => LiablitiyGuarantorMapper.fromJson(x))),
    userLoanLiabilityLiabilitiesMappers: List<UserLoanLiabilityLiabilitiesMapper>.from(json["userLoanLiabilityLiabilitiesMappers"].map((x) => UserLoanLiabilityLiabilitiesMapper.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "loanGuarantorMappers": List<dynamic>.from(loanGuarantorMappers!.map((x) => x.toJson())),
    "liablitiyGuarantorMappers": List<dynamic>.from(liablitiyGuarantorMappers!.map((x) => x.toJson())),
    "userLoanLiabilityLiabilitiesMappers": List<dynamic>.from(userLoanLiabilityLiabilitiesMappers!.map((x) => x.toJson())),
  };
}

class LiablitiyGuarantorMapper {
  int? id;
  int? accountStatusId;
  int? loanMasterId;
  int? bankMasterId;
  dynamic outstanding;
  String? guarantorName;
  String? accountStateName;
  String? bankType;
  String? bankName;
  dynamic loanAmount;

  LiablitiyGuarantorMapper({
    this.id,
    this.accountStatusId,
    this.loanMasterId,
    this.bankMasterId,
    this.outstanding,
    this.guarantorName,
    this.accountStateName,
    this.bankType,
    this.bankName,
    this.loanAmount,
  });

  LiablitiyGuarantorMapper copyWith({
    int? id,
    int? accountStatusId,
    int? loanMasterId,
    int? bankMasterId,
    dynamic outstanding,
    String? guarantorName,
    String? accountStateName,
    String? bankType,
    String? bankName,
    dynamic loanAmount,
  }) =>
      LiablitiyGuarantorMapper(
        id: id ?? this.id,
        accountStatusId: accountStatusId ?? this.accountStatusId,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        outstanding: outstanding ?? this.outstanding,
        guarantorName: guarantorName ?? this.guarantorName,
        accountStateName: accountStateName ?? this.accountStateName,
        bankType: bankType ?? this.bankType,
        bankName: bankName ?? this.bankName,
        loanAmount: loanAmount ?? this.loanAmount,
      );

  factory LiablitiyGuarantorMapper.fromJson(Map<String, dynamic> json) => LiablitiyGuarantorMapper(
    id: json["id"],
    accountStatusId: json["accountStatusId"],
    loanMasterId: json["loanMasterId"],
    bankMasterId: json["bankMasterId"],
    outstanding: json["outstanding"],
    guarantorName: json["guarantorName"],
    accountStateName: json["accountStateName"],
    bankType: json["bankType"],
    bankName: json["bankName"],
    loanAmount: json["loanAmount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountStatusId": accountStatusId,
    "loanMasterId": loanMasterId,
    "bankMasterId": bankMasterId,
    "outstanding": outstanding,
    "guarantorName": guarantorName,
    "accountStateName": accountStateName,
    "bankType": bankType,
    "bankName": bankName,
    "loanAmount": loanAmount,
  };
}

class LoanGuarantorMapper {
  int? id;
  String? address;
  int? occupationDataId;
  int? age;
  String? guarantorName;
  String? mobileNumber;
  String? occupationName;
  dynamic netWorth;
  int? loandMasterId;

  LoanGuarantorMapper({
    this.id,
    this.address,
    this.occupationDataId,
    this.age,
    this.guarantorName,
    this.mobileNumber,
    this.occupationName,
    this.netWorth,
    this.loandMasterId,
  });

  LoanGuarantorMapper copyWith({
    int? id,
    String? address,
    int? occupationDataId,
    int? age,
    String? guarantorName,
    String? mobileNumber,
    String? occupationName,
    dynamic netWorth,
    int? loandMasterId,
  }) =>
      LoanGuarantorMapper(
        id: id ?? this.id,
        address: address ?? this.address,
        occupationDataId: occupationDataId ?? this.occupationDataId,
        age: age ?? this.age,
        guarantorName: guarantorName ?? this.guarantorName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        occupationName: occupationName ?? this.occupationName,
        netWorth: netWorth ?? this.netWorth,
        loandMasterId: loandMasterId ?? this.loandMasterId,
      );

  factory LoanGuarantorMapper.fromJson(Map<String, dynamic> json) => LoanGuarantorMapper(
    id: json["id"],
    address: json["address"],
    occupationDataId: json["occupationDataId"],
    age: json["age"],
    guarantorName: json["guarantorName"],
    mobileNumber: json["mobileNumber"],
    occupationName: json["occupationName"],
    netWorth: json["netWorth"],
    loandMasterId: json["loandMasterId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "occupationDataId": occupationDataId,
    "age": age,
    "guarantorName": guarantorName,
    "mobileNumber": mobileNumber,
    "occupationName": occupationName,
    "netWorth": netWorth,
    "loandMasterId": loandMasterId,
  };
}

class UserLoanLiabilityLiabilitiesMapper {
  int? id;
  int? accountStatusId;
  int? securityOfferedId;
  int? loanMasterId;
  dynamic bankMasterId;
  int? farmerId;
  String? branchName;
  dynamic outstanding;
  String? accountStatusName;
  String? securityOfferedName;
  String? bankType;
  String? loanPurpose;
  String? bankName;

  UserLoanLiabilityLiabilitiesMapper({
    this.id,
    this.accountStatusId,
    this.securityOfferedId,
    this.loanMasterId,
    this.bankMasterId,
    this.farmerId,
    this.branchName,
    this.outstanding,
    this.accountStatusName,
    this.securityOfferedName,
    this.bankType,
    this.loanPurpose,
    this.bankName,
  });

  UserLoanLiabilityLiabilitiesMapper copyWith({
    int? id,
    int? accountStatusId,
    int? securityOfferedId,
    int? loanMasterId,
    dynamic bankMasterId,
    int? farmerId,
    String? branchName,
    dynamic outstanding,
    String? accountStatusName,
    String? securityOfferedName,
    String? bankType,
    String? loanPurpose,
    String? bankName,
  }) =>
      UserLoanLiabilityLiabilitiesMapper(
        id: id ?? this.id,
        accountStatusId: accountStatusId ?? this.accountStatusId,
        securityOfferedId: securityOfferedId ?? this.securityOfferedId,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        farmerId: farmerId ?? this.farmerId,
        branchName: branchName ?? this.branchName,
        outstanding: outstanding ?? this.outstanding,
        accountStatusName: accountStatusName ?? this.accountStatusName,
        securityOfferedName: securityOfferedName ?? this.securityOfferedName,
        bankType: bankType ?? this.bankType,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        bankName: bankName ?? this.bankName,
      );

  factory UserLoanLiabilityLiabilitiesMapper.fromJson(Map<String, dynamic> json) => UserLoanLiabilityLiabilitiesMapper(
    id: json["id"],
    accountStatusId: json["accountStatusId"],
    securityOfferedId: json["securityOfferedId"],
    loanMasterId: json["loanMasterId"],
    bankMasterId: json["bankMasterId"],
    farmerId: json["farmerId"],
    branchName: json["branchName"],
    outstanding: json["outstanding"],
    accountStatusName: json["accountStatusName"],
    securityOfferedName: json["securityOfferedName"],
    bankType: json["bankType"],
    loanPurpose: json["loanPurpose"],
    bankName: json["bankName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountStatusId": accountStatusId,
    "securityOfferedId": securityOfferedId,
    "loanMasterId": loanMasterId,
    "bankMasterId": bankMasterId,
    "farmerId": farmerId,
    "branchName": branchName,
    "outstanding": outstanding,
    "accountStatusName": accountStatusName,
    "securityOfferedName": securityOfferedName,
    "bankType": bankType,
    "loanPurpose": loanPurpose,
    "bankName": bankName,
  };
}
