// To parse this JSON data, do
//
//     final loanPurposeCubitModel = loanPurposeCubitModelFromJson(jsonString);

import 'dart:convert';

LoanPurposeCubitModel loanPurposeCubitModelFromJson(String str) =>
    LoanPurposeCubitModel.fromJson(json.decode(str));

String loanPurposeCubitModelToJson(LoanPurposeCubitModel data) =>
    json.encode(data.toJson());

class LoanPurposeCubitModel {
  String? firstAmount;
  String? secondAmount;
  String? thirdAmount;
  dynamic masterId;
  String? totalLandArea;
  String? otherDescription;
  bool? agriculture;
  bool? other;
  String? totalLandAreaUnitId;

  LoanPurposeCubitModel({
    this.firstAmount,
    this.secondAmount,
    this.thirdAmount,
    this.masterId,
    this.totalLandArea,
    this.otherDescription,
    this.agriculture,
    this.other,
    this.totalLandAreaUnitId,
  });

  LoanPurposeCubitModel copyWith(
          {String? firstAmount,
          String? secondAmount,
          String? thirdAmount,
          dynamic masterId,
          String? totalLandArea,
          String? otherDescription,
          bool? agriculture,
          bool? other,
          String? totalLandAreaUnitId}) =>
      LoanPurposeCubitModel(
          firstAmount: firstAmount ?? this.firstAmount,
          secondAmount: secondAmount ?? this.secondAmount,
          thirdAmount: thirdAmount ?? this.thirdAmount,
          masterId: masterId ?? this.masterId,
          totalLandArea: totalLandArea ?? this.totalLandArea,
          otherDescription: otherDescription ?? this.otherDescription,
          agriculture: agriculture ?? this.agriculture,
          other: other ?? this.other,
          totalLandAreaUnitId: totalLandAreaUnitId ?? this.totalLandAreaUnitId);

  factory LoanPurposeCubitModel.fromJson(Map<String, dynamic> json) =>
      LoanPurposeCubitModel(
          firstAmount: json["firstAmount"],
          secondAmount: json["secondAmount"],
          thirdAmount: json["thirdAmount"],
          masterId: json["masterId"],
          totalLandArea: json["totalLandArea"],
          otherDescription: json["otherDescription"],
          agriculture: json["agriculture"],
          other: json["other"],
          totalLandAreaUnitId: json["totalLandAreaUnitId"]);

  Map<String, dynamic> toJson() => {
        "firstAmount": firstAmount,
        "secondAmount": secondAmount,
        "thirdAmount": thirdAmount,
        "masterId": masterId,
        'totalLandArea': totalLandArea,
        "otherDescription": otherDescription,
        "agriculture": agriculture,
        "other": other,
        "totalLandAreaUnitId": totalLandAreaUnitId
      };
}
