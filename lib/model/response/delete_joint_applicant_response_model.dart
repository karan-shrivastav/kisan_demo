import 'dart:convert';

DeleteJointApplicantResponseModel deleteJointApplicantResponseModelFromJson(String str) => DeleteJointApplicantResponseModel.fromJson(json.decode(str));

String deleteJointApplicantResponseModelToJson(DeleteJointApplicantResponseModel data) => json.encode(data.toJson());

class DeleteJointApplicantResponseModel {
  int? status;
  String? message;
  bool? data;
  dynamic dataList;

  DeleteJointApplicantResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  DeleteJointApplicantResponseModel copyWith({
    int? status,
    String? message,
    bool? data,
    dynamic dataList,
  }) =>
      DeleteJointApplicantResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory DeleteJointApplicantResponseModel.fromJson(Map<String, dynamic> json) => DeleteJointApplicantResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": dataList,
  };
}
