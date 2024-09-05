import 'dart:convert';

DeleteFamilyReponseModel deleteFamilyReponseModelFromJson(String str) => DeleteFamilyReponseModel.fromJson(json.decode(str));

String deleteFamilyReponseModelToJson(DeleteFamilyReponseModel data) => json.encode(data.toJson());

class DeleteFamilyReponseModel {
    int? status;
    String? message;
    bool? data;
    dynamic dataList;

    DeleteFamilyReponseModel({
        this.status,
        this.message,
        this.data,
        this.dataList,
    });

    DeleteFamilyReponseModel copyWith({
        int? status,
        String? message,
        bool? data,
        dynamic dataList,
    }) => 
        DeleteFamilyReponseModel(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
            dataList: dataList ?? this.dataList,
        );

    factory DeleteFamilyReponseModel.fromJson(Map<String, dynamic> json) => DeleteFamilyReponseModel(
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
