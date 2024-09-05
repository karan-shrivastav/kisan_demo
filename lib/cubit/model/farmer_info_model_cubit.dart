// To parse this JSON data, do
//
//     final farmerInfoModelCubit = farmerInfoModelCubitFromJson(jsonString);

import 'dart:convert';

FarmerInfoModelCubit farmerInfoModelCubitFromJson(String str) =>
    FarmerInfoModelCubit.fromJson(json.decode(str));

String farmerInfoModelCubitToJson(FarmerInfoModelCubit data) =>
    json.encode(data.toJson());

class FarmerInfoModelCubit {
  String? mobileNumber;
  String? captcha;
  String? fromScreen;

  FarmerInfoModelCubit({this.mobileNumber, this.captcha, this.fromScreen});

  FarmerInfoModelCubit copyWith(
          {String? mobileNumber, String? captcha, String? fromScreen}) =>
      FarmerInfoModelCubit(
          mobileNumber: mobileNumber ?? this.mobileNumber,
          captcha: captcha ?? this.captcha,
          fromScreen: fromScreen ?? this.fromScreen);

  factory FarmerInfoModelCubit.fromJson(Map<String, dynamic> json) =>
      FarmerInfoModelCubit(
          mobileNumber: json["mobileNumber"],
          captcha: json["captcha"],
          fromScreen: json["fromScreen"]);

  Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNumber,
        "captcha": captcha,
        "fromScreen": fromScreen
      };
}
