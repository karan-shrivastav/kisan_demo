import 'dart:convert';

DeleteLandResponse deleteLandResponseFromJson(String str) =>
    DeleteLandResponse.fromJson(json.decode(str));

String deleteLandResponseToJson(DeleteLandResponse data) =>
    json.encode(data.toJson());

class DeleteLandResponse {
  int? status;
  String? message;
  dynamic data;
  dynamic dataList;

  DeleteLandResponse({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  factory DeleteLandResponse.fromJson(Map<String, dynamic> json) =>
      DeleteLandResponse(
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
