// To parse this JSON data, do
//
//     final appSharedPreferenceHelperModel = appSharedPreferenceHelperModelFromJson(jsonString);

import 'dart:convert';

AppSharedPreferenceHelperModel appSharedPreferenceHelperModelFromJson(
        String str) =>
    AppSharedPreferenceHelperModel.fromJson(json.decode(str));

String appSharedPreferenceHelperModelToJson(
        AppSharedPreferenceHelperModel data) =>
    json.encode(data.toJson());

class AppSharedPreferenceHelperModel {
  String? farmerId;
  String? userId;
  String? token;
  String? incompleteLoanId;

  AppSharedPreferenceHelperModel({
    this.farmerId,
    this.userId,
    this.token,
    this.incompleteLoanId,
  });

  AppSharedPreferenceHelperModel copyWith({
    String? farmerId,
    String? userId,
    String? token,
    String? incompleteLoanId,
  }) =>
      AppSharedPreferenceHelperModel(
        farmerId: farmerId ?? this.farmerId,
        userId: userId ?? this.userId,
        token: token ?? this.token,
        incompleteLoanId: incompleteLoanId ?? this.incompleteLoanId,
      );

  factory AppSharedPreferenceHelperModel.fromJson(Map<String, dynamic> json) =>
      AppSharedPreferenceHelperModel(
        farmerId: json["farmerId"],
        userId: json["userId"],
        token: json["token"],
        incompleteLoanId: json["incompleteLoanId"],
      );

  Map<String, dynamic> toJson() => {
        "farmerId": farmerId,
        "userId": userId,
        "token": token,
        "incompleteLoanId": incompleteLoanId,
      };
}
