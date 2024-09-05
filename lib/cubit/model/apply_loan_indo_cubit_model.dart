import 'dart:convert';

import 'crop_dtos.dart';




ApplyLoanModel applyLoanModelFromJson(String str) =>
    ApplyLoanModel.fromJson(json.decode(str));

String applyLoanModelToJson(ApplyLoanModel data) =>
    json.encode(data.toJson());

class ApplyLoanModel {
  String? stateName;
  int? stateId;
  String? districtName;
  int? districtId;
  String? bankName;
  int? bankMasterId;
  String? branchName;
  int? branchId;
  String? bankType;
  String? loanPurpose;
  String? covered;
  dynamic firstAmount;
  dynamic secondAmount;
  dynamic thirdAmount;
  dynamic totalAmount;
  String? jointApplicant;
  List<CropDetailDtos>? cropDetailDtos;
  dynamic presentMarketValue;
  dynamic agricultureIncome;
  dynamic otherIncome;
  dynamic alliedIncome;
  int? entityLevelId;
  String? entityLevelName;
  int? pacsLevelId;
  String? otherSecurityDesc;
  int? landTypeId;


  ApplyLoanModel({
    this.stateName,
    this.stateId,
    this.districtName,
    this.districtId,
    this.bankName,
    this.bankMasterId,
    this.branchName,
    this.branchId,
    this.bankType,
    this.loanPurpose,
    this.covered,
    this.cropDetailDtos,
    this.firstAmount,
    this.secondAmount,
    this.thirdAmount,
    this.totalAmount,
    this.jointApplicant,
    this.presentMarketValue,
    this.agricultureIncome,
    this.otherIncome,
    this.alliedIncome,
    this.entityLevelId,
    this.entityLevelName,
    this.pacsLevelId,
    this.otherSecurityDesc,
    this.landTypeId
  });

  ApplyLoanModel copyWith({
    String? stateName,
    int? stateId,
    String? districtName,
    int? districtId,
    String? bankName,
    int? bankMasterId,
    String? branchName,
    int? branchId,
    String? bankType,
    String? loanPurpose,
    String? covered,
    List<CropDetailDtos>? cropDetailDtos,
    dynamic firstAmount,
    dynamic secondAmount,
    dynamic thirdAmount,
    dynamic totalAmount,
    String? jointApplicant,
    dynamic presentMarketValue,
    dynamic agricultureIncome,
    dynamic otherIncome,
    dynamic alliedIncome,
    int? entityLevelId,
    String? entityLevelName,
    int? pacsLevelId,
    String? otherSecurityDesc,
    int ? landTypeId
  }) =>
      ApplyLoanModel(
        stateName: stateName ?? this.stateName,
        stateId: stateId ?? this.stateId,
        districtName: districtName ?? this.districtName,
        districtId: districtId ?? this.districtId,
        bankName: bankName ?? this.bankName,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        branchName: branchName ?? this.branchName,
        branchId: branchId ?? this.branchId,
        bankType: bankType ?? this.bankType,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        covered: covered ?? this.covered,
        cropDetailDtos: cropDetailDtos ?? this.cropDetailDtos,
        firstAmount: firstAmount ?? this.firstAmount,
        secondAmount: secondAmount ?? this.secondAmount,
        thirdAmount: thirdAmount ?? this.thirdAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        jointApplicant: jointApplicant ?? this.jointApplicant,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        agricultureIncome: agricultureIncome ?? this.agricultureIncome,
        otherIncome: otherIncome ?? this.otherIncome,
        alliedIncome: alliedIncome ?? this.alliedIncome,
        entityLevelId: entityLevelId ?? this.entityLevelId,
        entityLevelName: entityLevelName ?? this.entityLevelName,
        pacsLevelId: pacsLevelId ?? this.pacsLevelId,
        otherSecurityDesc: otherSecurityDesc ?? this.otherSecurityDesc,
        landTypeId: landTypeId ?? this.landTypeId
      );

  factory ApplyLoanModel.fromJson(Map<String, dynamic> json) =>
      ApplyLoanModel(
        stateName: json["stateName"],
        stateId: json["stateId"],
        districtName: json["districtName"],
        districtId: json["districtId"],
        bankName: json["bankName"],
        bankMasterId: json["bankMasterId"],
        branchName: json["branchName"],
        branchId: json["branchId"],
        bankType: json["bankType"],
        loanPurpose: json["loanPurpose"],
        covered: json["covered"],
        cropDetailDtos: json["cropDetailDtos"],
        firstAmount: json["firstAmount"],
        secondAmount: json["secondAmount"],
        thirdAmount: json["thirdAmount"],
        totalAmount: json["totalAmount"],
        jointApplicant: json["jointApplicant"],
        presentMarketValue: json["presentMarketValue"],
        agricultureIncome: json["agricultureIncome"],
        otherIncome: json["otherIncome"],
        alliedIncome: json["alliedIncome"],
        entityLevelId: json["entityLevelId"],
        entityLevelName: json["entityLevelName"],
        pacsLevelId: json["pacsLevelId"],
        otherSecurityDesc : json["otherSecurityDesc"],
        landTypeId: json["landTypeId"]
      );

  Map<String, dynamic> toJson() => {
    "stateName": stateName,
    "stateId": stateId,
    "districtName": districtName,
    "districtId": districtId,
    "bankName": districtName,
    "bankMasterId": bankMasterId,
    "branchName": branchName,
    "branchId": branchId,
    "bankType": bankType,
    "loanPurpose": loanPurpose,
    "covered": covered,
    "cropDetailDtos": cropDetailDtos,
    "firstAmount": firstAmount,
    "secondAmount": secondAmount,
    "thirdAmount": thirdAmount,
    "totalAmount": totalAmount,
    "jointApplicant": jointApplicant,
    "presentMarketValue": presentMarketValue,
    "agricultureIncome" : agricultureIncome,
    "otherIncome" : otherIncome,
    "alliedIncome" : alliedIncome,
    "entityLevelId" : entityLevelId,
    "entityLevelName": entityLevelName,
    "pacsLevelId" : pacsLevelId,
    "otherSecurityDesc" : otherSecurityDesc,
    "landTypeId":landTypeId
  };
}
