// To parse this JSON data, do
//
//     final sendOtpNewResponseModel = sendOtpNewResponseModelFromJson(jsonString);

import 'dart:convert';

SendOtpNewResponseModel sendOtpNewResponseModelFromJson(String str) => SendOtpNewResponseModel.fromJson(json.decode(str));

String sendOtpNewResponseModelToJson(SendOtpNewResponseModel data) => json.encode(data.toJson());

class SendOtpNewResponseModel {
  int ?status;
  String ?message;


  SendOtpNewResponseModel({
    this.status,
    this.message,
  });

  SendOtpNewResponseModel copyWith({
    int? status,
    String? message,
  }) =>
      SendOtpNewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,

      );

  factory SendOtpNewResponseModel.fromJson(Map<String, dynamic> json) => SendOtpNewResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
