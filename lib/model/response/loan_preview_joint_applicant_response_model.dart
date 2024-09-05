// To parse this JSON data, do
//
//     final basicDetailsNewResponseModel = basicDetailsNewResponseModelFromJson(jsonString);

import 'dart:convert';

BasicDetailsNewResponseModel basicDetailsNewResponseModelFromJson(String str) => BasicDetailsNewResponseModel.fromJson(json.decode(str));

String basicDetailsNewResponseModelToJson(BasicDetailsNewResponseModel data) => json.encode(data.toJson());

class BasicDetailsNewResponseModel {
  int ?status;
  String ?message;
  Data ?data;
  dynamic dataList;

  BasicDetailsNewResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  BasicDetailsNewResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      BasicDetailsNewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory BasicDetailsNewResponseModel.fromJson(Map<String, dynamic> json) => BasicDetailsNewResponseModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class Data {
  int ?hypothecationOfCrop;
  int ?agrcultureLand;
  int ?otherIfAny;
  List<ApplicantDto> ?applicantDtos;

  Data({
    this.hypothecationOfCrop,
    this.agrcultureLand,
    this.otherIfAny,
    this.applicantDtos,
  });

  Data copyWith({
    int? hypothecationOfCrop,
    int? agrcultureLand,
    int? otherIfAny,
    List<ApplicantDto>? applicantDtos,
  }) =>
      Data(
        hypothecationOfCrop: hypothecationOfCrop ?? this.hypothecationOfCrop,
        agrcultureLand: agrcultureLand ?? this.agrcultureLand,
        otherIfAny: otherIfAny ?? this.otherIfAny,
        applicantDtos: applicantDtos ?? this.applicantDtos,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hypothecationOfCrop: json["hypothecationOfCrop"],
    agrcultureLand: json["agrcultureLand"],
    otherIfAny: json["otherIfAny"],
    applicantDtos: List<ApplicantDto>.from(json["applicantDtos"].map((x) => ApplicantDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hypothecationOfCrop": hypothecationOfCrop,
    "agrcultureLand": agrcultureLand,
    "otherIfAny": otherIfAny,
    "applicantDtos": List<dynamic>.from(applicantDtos!.map((x) => x.toJson())),
  };
}

class ApplicantDto {
  int? id;
  int ?farmerId;
  String ?joinApplicantName;
  String? idNumber;
  DateTime ?dateOfBirth;
  int? genderId;
  int ?relationId;
  int ?idProodId;
  String ?genderName;
  String ?relationName;
  String ?idProodName;

  ApplicantDto({
    this.id,
    this.farmerId,
    this.joinApplicantName,
    this.idNumber,
    this.dateOfBirth,
    this.genderId,
    this.relationId,
    this.idProodId,
    this.genderName,
    this.relationName,
    this.idProodName,
  });

  ApplicantDto copyWith({
    int? id,
    int? farmerId,
    String? joinApplicantName,
    String? idNumber,
    DateTime? dateOfBirth,
    int? genderId,
    int? relationId,
    int? idProodId,
    String? genderName,
    String? relationName,
    String? idProodName,
  }) =>
      ApplicantDto(
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        joinApplicantName: joinApplicantName ?? this.joinApplicantName,
        idNumber: idNumber ?? this.idNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        genderId: genderId ?? this.genderId,
        relationId: relationId ?? this.relationId,
        idProodId: idProodId ?? this.idProodId,
        genderName: genderName ?? this.genderName,
        relationName: relationName ?? this.relationName,
        idProodName: idProodName ?? this.idProodName,
      );

  factory ApplicantDto.fromJson(Map<String, dynamic> json) => ApplicantDto(
    id: json["id"],
    farmerId: json["farmerId"],
    joinApplicantName: json["joinApplicantName"],
    idNumber: json["idNumber"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    genderId: json["genderId"],
    relationId: json["relationId"],
    idProodId: json["idProodId"],
    genderName: json["genderName"],
    relationName: json["relationName"],
    idProodName: json["idProodName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "farmerId": farmerId,
    "joinApplicantName": joinApplicantName,
    "idNumber": idNumber,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "genderId": genderId,
    "relationId": relationId,
    "idProodId": idProodId,
    "genderName": genderName,
    "relationName": relationName,
    "idProodName": idProodName,
  };
}
