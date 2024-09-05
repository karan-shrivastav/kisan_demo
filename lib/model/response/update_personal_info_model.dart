import 'dart:convert';

UpdatePersonalInfoModel updatePersonalInfoModelFromJson(String str) =>
    UpdatePersonalInfoModel.fromJson(json.decode(str));

String updatePersonalInfoModelToJson(UpdatePersonalInfoModel data) =>
    json.encode(data.toJson());

class UpdatePersonalInfoModel {
  int? status;
  String? message;
  String? data;
  dynamic dataList;

  UpdatePersonalInfoModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  UpdatePersonalInfoModel copyWith({
    int? status,
    String? message,
    String? data,
    dynamic dataList,
  }) =>
      UpdatePersonalInfoModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory UpdatePersonalInfoModel.fromJson(Map<String, dynamic> json) =>
      UpdatePersonalInfoModel(
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
