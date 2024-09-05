// To parse this JSON data, do
//
//     final otherDetailsCubitModel = otherDetailsCubitModelFromJson(jsonString);

import 'dart:convert';

OtherDetailsCubitModel otherDetailsCubitModelFromJson(String str) =>
    OtherDetailsCubitModel.fromJson(json.decode(str));

String otherDetailsCubitModelToJson(OtherDetailsCubitModel data) =>
    json.encode(data.toJson());

class OtherDetailsCubitModel {
  LoanMasterOtherDetailsRequestPayload? loanMasterOtherDetailsRequestPayload;
  List<LoanAsset>? loanAsset;
  List<LoanGuarantorsList>? loanGuarantorsList;
  List<LoanLiabilityGuarantor>? loanLiabilityGuarantors;
  List<UserLoanLiabilitiesList>? userLoanLiabilitiesList;
  int? masterId;

  OtherDetailsCubitModel({
    this.loanMasterOtherDetailsRequestPayload,
    this.loanAsset,
    this.loanGuarantorsList,
    this.loanLiabilityGuarantors,
    this.userLoanLiabilitiesList,
    this.masterId,
  });

  OtherDetailsCubitModel copyWith({
    LoanMasterOtherDetailsRequestPayload? loanMasterOtherDetailsRequestPayload,
    List<LoanAsset>? loanAsset,
    List<LoanGuarantorsList>? loanGuarantorsList,
    List<LoanLiabilityGuarantor>? loanLiabilityGuarantors,
    List<UserLoanLiabilitiesList>? userLoanLiabilitiesList,
    int? masterId,
  }) =>
      OtherDetailsCubitModel(
        loanMasterOtherDetailsRequestPayload:
            loanMasterOtherDetailsRequestPayload ??
                this.loanMasterOtherDetailsRequestPayload,
        loanAsset: loanAsset ?? this.loanAsset,
        loanGuarantorsList: loanGuarantorsList ?? this.loanGuarantorsList,
        loanLiabilityGuarantors:
            loanLiabilityGuarantors ?? this.loanLiabilityGuarantors,
        userLoanLiabilitiesList:
            userLoanLiabilitiesList ?? this.userLoanLiabilitiesList,
        masterId: masterId ?? this.masterId,
      );

  factory OtherDetailsCubitModel.fromJson(Map<String, dynamic> json) =>
      OtherDetailsCubitModel(
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
        masterId: json["masterId"],
      );

  Map<String, dynamic> toJson() => {
        "loanMasterOtherDetailsRequestPayload":
            loanMasterOtherDetailsRequestPayload?.toJson(),
        "loanAsset": List<dynamic>.from(loanAsset!.map((x) => x.toJson())),
        "loanGuarantorsList":
            List<dynamic>.from(loanGuarantorsList!.map((x) => x.toJson())),
        "loanLiabilityGuarantors":
            List<dynamic>.from(loanLiabilityGuarantors!.map((x) => x.toJson())),
        "userLoanLiabilitiesList":
            List<dynamic>.from(userLoanLiabilitiesList!.map((x) => x.toJson())),
        "masterId": masterId,
      };
}

class LoanAsset {
  dynamic id;
  String? loanMasterId;
  String? assetDataId;
  String? assestTypeId;
  String? particulars;
  String? presentMarketValue;
  String? assetName;
  String? listId;
  String? assetType;

  LoanAsset(
      {this.id,
      this.loanMasterId,
      this.assetDataId,
      this.assestTypeId,
      this.particulars,
      this.presentMarketValue,
      this.assetName,
      this.listId,
      this.assetType});

  LoanAsset copyWith({
    dynamic id,
    String? loanMasterId,
    String? assetDataId,
    String? assestTypeId,
    String? particulars,
    String? presentMarketValue,
    String? assetName,
    String? listId,
    String? assetType,
  }) =>
      LoanAsset(
        loanMasterId: loanMasterId ?? this.loanMasterId,
        assetDataId: assetDataId ?? this.assetDataId,
        assestTypeId: assestTypeId ?? this.assestTypeId,
        particulars: particulars ?? this.particulars,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        assetName: assetName ?? this.assetName,
        listId: listId ?? this.listId,
        assetType: assetType ?? this.assetType,
      );

  factory LoanAsset.fromJson(Map<String, dynamic> json) => LoanAsset(
      id: json["id"],
      loanMasterId: json["loanMasterId"],
      assetDataId: json["assetDataId"],
      assestTypeId: json["assestTypeId"],
      particulars: json["particulars"],
      presentMarketValue: json["presentMarketValue"],
      assetName: json["assetName"],
      listId: json["listId"],
      assetType: json["assetType"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "loanMasterId": loanMasterId,
        "assetDataId": assetDataId,
        "assestTypeId": assestTypeId,
        "particulars": particulars,
        "presentMarketValue": presentMarketValue,
        "assetName": assetName,
        "listId": listId,
        "assetType": assetType
      };
}

class LoanGuarantorsList {
  int? id;
  String? occupationDataId;
  String? guarantorName;
  String? age;
  String? address;
  String? mobileNumber;
  String? netWorth;
  String? listId;

  LoanGuarantorsList(
      {this.id,
      this.occupationDataId,
      this.guarantorName,
      this.age,
      this.address,
      this.mobileNumber,
      this.netWorth,
      this.listId,
      });

  LoanGuarantorsList copyWith({
    int? id,
    String? occupationDataId,
    String? guarantorName,
    String? age,
    String? address,
    String? mobileNumber,
    String? netWorth,
    String? listId,
  }) =>
      LoanGuarantorsList(
          id: id ?? this.id,
          occupationDataId: occupationDataId ?? this.occupationDataId,
          guarantorName: guarantorName ?? this.guarantorName,
          age: age ?? this.age,
          address: address ?? this.address,
          mobileNumber: mobileNumber ?? this.mobileNumber,
          netWorth: netWorth ?? this.netWorth,
          listId: listId ?? this.listId);

  factory LoanGuarantorsList.fromJson(Map<String, dynamic> json) =>
      LoanGuarantorsList(
          id: json["id"],
          occupationDataId: json["occupationDataId"],
          guarantorName: json["guarantorName"],
          age: json["age"],
          address: json["address"],
          mobileNumber: json["mobileNumber"],
          netWorth: json["netWorth"],
          listId: json["listId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "occupationDataId": occupationDataId,
        "guarantorName": guarantorName,
        "age": age,
        "address": address,
        "mobileNumber": mobileNumber,
        "netWorth": netWorth,
        "listId": listId
      };
}

class LoanLiabilityGuarantor {
  int? id;
  String? bankMasterId;
  String? guarantorName;
  String? loanAmount;
  String? outstanding;
  String? accountStatus;
  String? bankName;
  String? accountStatusName;
  String? listId;


  LoanLiabilityGuarantor({
    this.id,
    this.bankMasterId,
    this.guarantorName,
    this.loanAmount,
    this.outstanding,
    this.accountStatus,
    this.bankName,
    this.accountStatusName,
    this.listId,
  });

  LoanLiabilityGuarantor copyWith({
    int? id,
    String? bankMasterId,
    String? guarantorName,
    String? loanAmount,
    String? outstanding,
    String? accountStatus,
    String? bankName,
    String? accountStatusName,
    String? listId,
  }) =>
      LoanLiabilityGuarantor(
          id: id ?? this.id,
          bankMasterId: bankMasterId ?? this.bankMasterId,
          guarantorName: guarantorName ?? this.guarantorName,
          loanAmount: loanAmount ?? this.loanAmount,
          outstanding: outstanding ?? this.outstanding,
          accountStatus: accountStatus ?? this.accountStatus,
          bankName: bankName ?? this.bankName,
          accountStatusName: accountStatusName ?? this.accountStatusName,
          listId: listId ?? this.listId);

  factory LoanLiabilityGuarantor.fromJson(Map<String, dynamic> json) =>
      LoanLiabilityGuarantor(
        id: json["id"],
        bankMasterId: json["bankMasterId"],
        guarantorName: json["guarantorName"],
        loanAmount: json["loanAmount"],
        outstanding: json["outstanding"],
        accountStatus: json["account_status"],
        bankName: json["bankName"],
        accountStatusName: json["accountStatusName"],
        listId: json["listId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bankMasterId": bankMasterId,
        "guarantorName": guarantorName,
        "loanAmount": loanAmount,
        "outstanding": outstanding,
        "account_status": accountStatus,
        "bankName": bankName,
        "accountStatusName": accountStatusName,
        "listId": listId
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
  int? id;
  String? farmerId;
  String? accountStatusId;
  String? securityOfferedId;
  String? bankName;
  String? branchName;
  String? loanPurpose;
  String? outstanding;
  String? bankType;
  String? listId;

  UserLoanLiabilitiesList(
      {this.id,
      this.farmerId,
      this.accountStatusId,
      this.securityOfferedId,
      this.bankName,
      this.branchName,
      this.loanPurpose,
      this.outstanding,
      this.bankType,
      this.listId});

  UserLoanLiabilitiesList copyWith({
    int? id,
    String? farmerId,
    String? accountStatusId,
    String? securityOfferedId,
    String? bankName,
    String? branchName,
    String? loanPurpose,
    String? outstanding,
    String? bankType,
    String? listId,
  }) =>
      UserLoanLiabilitiesList(
          id: id ?? this.id,
          farmerId: farmerId ?? this.farmerId,
          accountStatusId: accountStatusId ?? this.accountStatusId,
          securityOfferedId: securityOfferedId ?? this.securityOfferedId,
          bankName: bankName ?? this.bankName,
          branchName: branchName ?? this.branchName,
          loanPurpose: loanPurpose ?? this.loanPurpose,
          outstanding: outstanding ?? this.outstanding,
          bankType: bankType ?? this.bankType,
          listId: listId ?? this.listId);

  factory UserLoanLiabilitiesList.fromJson(Map<String, dynamic> json) =>
      UserLoanLiabilitiesList(
          id: json["id"],
          farmerId: json["farmerId"],
          accountStatusId: json["accountStatusId"],
          securityOfferedId: json["securityOfferedId"],
          bankName: json["bankName"],
          branchName: json["branchName"],
          loanPurpose: json["loanPurpose"],
          outstanding: json["outstanding"],
          bankType: json["bankType"],
          listId: json["listId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "farmerId": farmerId,
        "accountStatusId": accountStatusId,
        "securityOfferedId": securityOfferedId,
        "bankName": bankName,
        "branchName": branchName,
        "loanPurpose": loanPurpose,
        "outstanding": outstanding,
        "bankType": bankType,
        "listId": listId
      };
}
