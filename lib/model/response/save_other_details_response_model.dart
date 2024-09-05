// To parse this JSON data, do
//
//     final saveOtherDetailsSuccessResponseModel = saveOtherDetailsSuccessResponseModelFromJson(jsonString);

import 'dart:convert';

SaveOtherDetailsSuccessResponseModel
saveOtherDetailsSuccessResponseModelFromJson(String str) =>
    SaveOtherDetailsSuccessResponseModel.fromJson(json.decode(str));

String saveOtherDetailsSuccessResponseModelToJson(
    SaveOtherDetailsSuccessResponseModel data) =>
    json.encode(data.toJson());

class SaveOtherDetailsSuccessResponseModel {
  dynamic status;
  String? message;
  Data? data;
  dynamic dataList;

  SaveOtherDetailsSuccessResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  SaveOtherDetailsSuccessResponseModel copyWith({
    dynamic status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      SaveOtherDetailsSuccessResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory SaveOtherDetailsSuccessResponseModel.fromJson(
      Map<String, dynamic> json) =>
      SaveOtherDetailsSuccessResponseModel(
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
  LoanMasterOtherDetailsRequestPayload? loanMasterOtherDetailsRequestPayload;
  List<LoanAsset>? loanAsset;
  List<LoanGuarantorsList>? loanGuarantorsList;
  List<LoanLiabilityGuarantor>? loanLiabilityGuarantors;
  List<UserLoanLiabilitiesList>? userLoanLiabilitiesList;

  Data({
    this.loanMasterOtherDetailsRequestPayload,
    this.loanAsset,
    this.loanGuarantorsList,
    this.loanLiabilityGuarantors,
    this.userLoanLiabilitiesList,
  });

  Data copyWith({
    LoanMasterOtherDetailsRequestPayload? loanMasterOtherDetailsRequestPayload,
    List<LoanAsset>? loanAsset,
    List<LoanGuarantorsList>? loanGuarantorsList,
    List<LoanLiabilityGuarantor>? loanLiabilityGuarantors,
    List<UserLoanLiabilitiesList>? userLoanLiabilitiesList,
  }) =>
      Data(
        loanMasterOtherDetailsRequestPayload:
        loanMasterOtherDetailsRequestPayload ??
            this.loanMasterOtherDetailsRequestPayload,
        loanAsset: loanAsset ?? this.loanAsset,
        loanGuarantorsList: loanGuarantorsList ?? this.loanGuarantorsList,
        loanLiabilityGuarantors:
        loanLiabilityGuarantors ?? this.loanLiabilityGuarantors,
        userLoanLiabilitiesList:
        userLoanLiabilitiesList ?? this.userLoanLiabilitiesList,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    loanMasterOtherDetailsRequestPayload:
    LoanMasterOtherDetailsRequestPayload.fromJson(
        json["loanMasterOtherDetailsRequestPayload"]),
    loanAsset: List<LoanAsset>.from(
        json["loanAsset"].map((x) => LoanAsset.fromJson(x))),
    loanGuarantorsList: List<LoanGuarantorsList>.from(
        json["loanGuarantorsList"]
            .map((x) => LoanGuarantorsList.fromJson(x))),
    loanLiabilityGuarantors: List<LoanLiabilityGuarantor>.from(
        json["loanLiabilityGuarantors"]
            .map((x) => LoanLiabilityGuarantor.fromJson(x))),
    userLoanLiabilitiesList: List<UserLoanLiabilitiesList>.from(
        json["userLoanLiabilitiesList"]
            .map((x) => UserLoanLiabilitiesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "loanMasterOtherDetailsRequestPayload":
    loanMasterOtherDetailsRequestPayload!.toJson(),
    "loanAsset": List<dynamic>.from(loanAsset!.map((x) => x.toJson())),
    "loanGuarantorsList":
    List<dynamic>.from(loanGuarantorsList!.map((x) => x.toJson())),
    "loanLiabilityGuarantors":
    List<dynamic>.from(loanLiabilityGuarantors!.map((x) => x.toJson())),
    "userLoanLiabilitiesList":
    List<dynamic>.from(userLoanLiabilitiesList!.map((x) => x.toJson())),
  };
}

class LoanAsset {
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  dynamic id;
  dynamic loanMaster;
  dynamic loanMasterId;
  dynamic assetData;
  dynamic assetDataId;
  dynamic assetDataName;
  String? particulars;
  dynamic presentMarketValue;
  dynamic assestType;
  dynamic assestTypeId;
  dynamic assestTypeName;

  LoanAsset({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.loanMaster,
    this.loanMasterId,
    this.assetData,
    this.assetDataId,
    this.assetDataName,
    this.particulars,
    this.presentMarketValue,
    this.assestType,
    this.assestTypeId,
    this.assestTypeName,
  });

  LoanAsset copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    dynamic id,
    dynamic loanMaster,
    dynamic loanMasterId,
    dynamic assetData,
    dynamic assetDataId,
    dynamic assetDataName,
    String? particulars,
    dynamic presentMarketValue,
    dynamic assestType,
    dynamic assestTypeId,
    dynamic assestTypeName,
  }) =>
      LoanAsset(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        loanMaster: loanMaster ?? this.loanMaster,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        assetData: assetData ?? this.assetData,
        assetDataId: assetDataId ?? this.assetDataId,
        assetDataName: assetDataName ?? this.assetDataName,
        particulars: particulars ?? this.particulars,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        assestType: assestType ?? this.assestType,
        assestTypeId: assestTypeId ?? this.assestTypeId,
        assestTypeName: assestTypeName ?? this.assestTypeName,
      );

  factory LoanAsset.fromJson(Map<String, dynamic> json) => LoanAsset(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    loanMaster: json["loanMaster"],
    loanMasterId: json["loanMasterId"],
    assetData: json["assetData"],
    assetDataId: json["assetDataId"],
    assetDataName: json["assetDataName"],
    particulars: json["particulars"],
    presentMarketValue: json["presentMarketValue"],
    assestType: json["assestType"],
    assestTypeId: json["assestTypeId"],
    assestTypeName: json["assestTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "loanMaster": loanMaster,
    "loanMasterId": loanMasterId,
    "assetData": assetData,
    "assetDataId": assetDataId,
    "assetDataName": assetDataName,
    "particulars": particulars,
    "presentMarketValue": presentMarketValue,
    "assestType": assestType,
    "assestTypeId": assestTypeId,
    "assestTypeName": assestTypeName,
  };
}

class LoanGuarantorsList {
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  dynamic id;
  dynamic loanMaster;
  dynamic loanMasterId;
  dynamic occupationData;
  dynamic occupationDataId;
  dynamic occupationDataName;
  String? guarantorName;
  dynamic age;
  String? address;
  String? mobileNumber;
  dynamic netWorth;

  LoanGuarantorsList({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.loanMaster,
    this.loanMasterId,
    this.occupationData,
    this.occupationDataId,
    this.occupationDataName,
    this.guarantorName,
    this.age,
    this.address,
    this.mobileNumber,
    this.netWorth,
  });

  LoanGuarantorsList copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    dynamic id,
    dynamic loanMaster,
    dynamic loanMasterId,
    dynamic occupationData,
    dynamic occupationDataId,
    dynamic occupationDataName,
    String? guarantorName,
    dynamic age,
    String? address,
    String? mobileNumber,
    dynamic netWorth,
  }) =>
      LoanGuarantorsList(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        loanMaster: loanMaster ?? this.loanMaster,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        occupationData: occupationData ?? this.occupationData,
        occupationDataId: occupationDataId ?? this.occupationDataId,
        occupationDataName: occupationDataName ?? this.occupationDataName,
        guarantorName: guarantorName ?? this.guarantorName,
        age: age ?? this.age,
        address: address ?? this.address,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        netWorth: netWorth ?? this.netWorth,
      );

  factory LoanGuarantorsList.fromJson(Map<String, dynamic> json) =>
      LoanGuarantorsList(
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        loanMaster: json["loanMaster"],
        loanMasterId: json["loanMasterId"],
        occupationData: json["occupationData"],
        occupationDataId: json["occupationDataId"],
        occupationDataName: json["occupationDataName"],
        guarantorName: json["guarantorName"],
        age: json["age"],
        address: json["address"],
        mobileNumber: json["mobileNumber"],
        netWorth: json["netWorth"],
      );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "loanMaster": loanMaster,
    "loanMasterId": loanMasterId,
    "occupationData": occupationData,
    "occupationDataId": occupationDataId,
    "occupationDataName": occupationDataName,
    "guarantorName": guarantorName,
    "age": age,
    "address": address,
    "mobileNumber": mobileNumber,
    "netWorth": netWorth,
  };
}

class LoanLiabilityGuarantor {
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  dynamic id;
  dynamic loanMaster;
  dynamic loanMasterId;
  String? guarantorName;
  dynamic bankMasterId;
  dynamic loanAmount;
  dynamic outstanding;
  dynamic accountStatus;
  dynamic loanLiabilityGuarantorAccountStatus;
  dynamic accountStatusName;

  LoanLiabilityGuarantor({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.loanMaster,
    this.loanMasterId,
    this.guarantorName,
    this.bankMasterId,
    this.loanAmount,
    this.outstanding,
    this.accountStatus,
    this.loanLiabilityGuarantorAccountStatus,
    this.accountStatusName,
  });

  LoanLiabilityGuarantor copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    dynamic id,
    dynamic loanMaster,
    dynamic loanMasterId,
    String? guarantorName,
    dynamic bankMasterId,
    dynamic loanAmount,
    dynamic outstanding,
    dynamic accountStatus,
    dynamic loanLiabilityGuarantorAccountStatus,
    dynamic accountStatusName,
  }) =>
      LoanLiabilityGuarantor(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        loanMaster: loanMaster ?? this.loanMaster,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        guarantorName: guarantorName ?? this.guarantorName,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        loanAmount: loanAmount ?? this.loanAmount,
        outstanding: outstanding ?? this.outstanding,
        accountStatus: accountStatus ?? this.accountStatus,
        loanLiabilityGuarantorAccountStatus:
        loanLiabilityGuarantorAccountStatus ??
            this.loanLiabilityGuarantorAccountStatus,
        accountStatusName: accountStatusName ?? this.accountStatusName,
      );

  factory LoanLiabilityGuarantor.fromJson(Map<String, dynamic> json) =>
      LoanLiabilityGuarantor(
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        loanMaster: json["loanMaster"],
        loanMasterId: json["loanMasterId"],
        guarantorName: json["guarantorName"],
        bankMasterId: json["bankMasterId"],
        loanAmount: json["loanAmount"],
        outstanding: json["outstanding"],
        accountStatus: json["accountStatus"],
        loanLiabilityGuarantorAccountStatus: json["account_status"],
        accountStatusName: json["accountStatusName"],
      );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "loanMaster": loanMaster,
    "loanMasterId": loanMasterId,
    "guarantorName": guarantorName,
    "bankMasterId": bankMasterId,
    "loanAmount": loanAmount,
    "outstanding": outstanding,
    "accountStatus": accountStatus,
    "account_status": loanLiabilityGuarantorAccountStatus,
    "accountStatusName": accountStatusName,
  };
}

class LoanMasterOtherDetailsRequestPayload {
  String? agricultureIncome;
  String? otherIncome;
  String? alliedIncome;
  String? lastYear;

  LoanMasterOtherDetailsRequestPayload({
    this.agricultureIncome,
    this.otherIncome,
    this.alliedIncome,
    this.lastYear,
  });

  LoanMasterOtherDetailsRequestPayload copyWith({
    String? agricultureIncome,
    String? otherIncome,
    String? alliedIncome,
    String? lastYear,
  }) =>
      LoanMasterOtherDetailsRequestPayload(
        agricultureIncome: agricultureIncome ?? this.agricultureIncome,
        otherIncome: otherIncome ?? this.otherIncome,
        alliedIncome: alliedIncome ?? this.alliedIncome,
        lastYear: lastYear ?? this.lastYear,
      );

  factory LoanMasterOtherDetailsRequestPayload.fromJson(
      Map<String, dynamic> json) =>
      LoanMasterOtherDetailsRequestPayload(
        agricultureIncome: json["agricultureIncome"],
        otherIncome: json["otherIncome"],
        alliedIncome: json["alliedIncome"],
        lastYear: json["lastYear"],
      );

  Map<String, dynamic> toJson() => {
    "agricultureIncome": agricultureIncome,
    "otherIncome": otherIncome,
    "alliedIncome": alliedIncome,
    "lastYear": lastYear,
  };
}

class UserLoanLiabilitiesList {
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  dynamic id;
  dynamic farmerId;
  dynamic accountStatus;
  dynamic accountStatusId;
  dynamic accountStatusName;
  dynamic securityOffered;
  dynamic securityOfferedId;
  dynamic securityOfferedName;
  String? bankName;
  String? branchName;
  String? loanPurpose;
  dynamic outstanding;
  dynamic loanMaster;
  dynamic loanMasterId;
  String? bankType;
  dynamic bankMasterId;

  UserLoanLiabilitiesList({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.farmerId,
    this.accountStatus,
    this.accountStatusId,
    this.accountStatusName,
    this.securityOffered,
    this.securityOfferedId,
    this.securityOfferedName,
    this.bankName,
    this.branchName,
    this.loanPurpose,
    this.outstanding,
    this.loanMaster,
    this.loanMasterId,
    this.bankType,
    this.bankMasterId,
  });

  UserLoanLiabilitiesList copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    dynamic id,
    dynamic farmerId,
    dynamic accountStatus,
    dynamic accountStatusId,
    dynamic accountStatusName,
    dynamic securityOffered,
    dynamic securityOfferedId,
    dynamic securityOfferedName,
    String? bankName,
    String? branchName,
    String? loanPurpose,
    dynamic outstanding,
    dynamic loanMaster,
    dynamic loanMasterId,
    String? bankType,
    dynamic bankMasterId,
  }) =>
      UserLoanLiabilitiesList(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        accountStatus: accountStatus ?? this.accountStatus,
        accountStatusId: accountStatusId ?? this.accountStatusId,
        accountStatusName: accountStatusName ?? this.accountStatusName,
        securityOffered: securityOffered ?? this.securityOffered,
        securityOfferedId: securityOfferedId ?? this.securityOfferedId,
        securityOfferedName: securityOfferedName ?? this.securityOfferedName,
        bankName: bankName ?? this.bankName,
        branchName: branchName ?? this.branchName,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        outstanding: outstanding ?? this.outstanding,
        loanMaster: loanMaster ?? this.loanMaster,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        bankType: bankType ?? this.bankType,
        bankMasterId: bankMasterId ?? this.bankMasterId,
      );

  factory UserLoanLiabilitiesList.fromJson(Map<String, dynamic> json) =>
      UserLoanLiabilitiesList(
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        farmerId: json["farmerId"],
        accountStatus: json["accountStatus"],
        accountStatusId: json["accountStatusId"],
        accountStatusName: json["accountStatusName"],
        securityOffered: json["securityOffered"],
        securityOfferedId: json["securityOfferedId"],
        securityOfferedName: json["securityOfferedName"],
        bankName: json["bankName"],
        branchName: json["branchName"],
        loanPurpose: json["loanPurpose"],
        outstanding: json["outstanding"],
        loanMaster: json["loanMaster"],
        loanMasterId: json["loanMasterId"],
        bankType: json["bankType"],
        bankMasterId: json["bankMasterId"],
      );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "farmerId": farmerId,
    "accountStatus": accountStatus,
    "accountStatusId": accountStatusId,
    "accountStatusName": accountStatusName,
    "securityOffered": securityOffered,
    "securityOfferedId": securityOfferedId,
    "securityOfferedName": securityOfferedName,
    "bankName": bankName,
    "branchName": branchName,
    "loanPurpose": loanPurpose,
    "outstanding": outstanding,
    "loanMaster": loanMaster,
    "loanMasterId": loanMasterId,
    "bankType": bankType,
    "bankMasterId": bankMasterId,
  };
}
