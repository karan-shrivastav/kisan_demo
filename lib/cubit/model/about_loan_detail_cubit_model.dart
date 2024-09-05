// To parse this JSON data, do
//
//     final aboutLoanDetailCubitModel = aboutLoanDetailCubitModelFromJson(jsonString);

import 'dart:convert';

AboutLoanDetailCubitModel aboutLoanDetailCubitModelFromJson(String str) => AboutLoanDetailCubitModel.fromJson(json.decode(str));

String aboutLoanDetailCubitModelToJson(AboutLoanDetailCubitModel data) => json.encode(data.toJson());

class AboutLoanDetailCubitModel {
  String? loanId;
  String ?applicationId;

  AboutLoanDetailCubitModel({
    this.loanId,
    this.applicationId,
  });

  AboutLoanDetailCubitModel copyWith({
    String? loanId,
    String? applicationId,
  }) =>
      AboutLoanDetailCubitModel(
        loanId: loanId ?? this.loanId,
        applicationId: applicationId ?? this.applicationId,
      );

  factory AboutLoanDetailCubitModel.fromJson(Map<String, dynamic> json) => AboutLoanDetailCubitModel(
    loanId: json["loanId"],
    applicationId: json["applicationId"],
  );

  Map<String, dynamic> toJson() => {
    "loanId": loanId,
    "applicationId": applicationId,
  };
}
