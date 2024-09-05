import 'dart:convert';

SelectedJointApplicantResponseModel selectedJointApplicantResponseModelFromJson(String str) => SelectedJointApplicantResponseModel.fromJson(json.decode(str));

String selectedJointApplicantResponseModelToJson(SelectedJointApplicantResponseModel data) => json.encode(data.toJson());

class SelectedJointApplicantResponseModel {
  int? status;
  String? message;
  SelectedJointApplicantDataData? data;
  dynamic dataList;

  SelectedJointApplicantResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  SelectedJointApplicantResponseModel copyWith({
    int? status,
    String? message,
    SelectedJointApplicantDataData? data,
    dynamic dataList,
  }) =>
      SelectedJointApplicantResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory SelectedJointApplicantResponseModel.fromJson(Map<String, dynamic> json) => SelectedJointApplicantResponseModel(
    status: json["status"],
    message: json["message"],
    data: SelectedJointApplicantDataData.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class SelectedJointApplicantDataData {
  int? hypothecationOfCrop;
  int? agrcultureLand;
  int? otherIfAny;
  List<ApplicantDto>? applicantDtos;

  SelectedJointApplicantDataData({
    this.hypothecationOfCrop,
    this.agrcultureLand,
    this.otherIfAny,
    this.applicantDtos,
  });

  SelectedJointApplicantDataData copyWith({
    int? hypothecationOfCrop,
    int? agrcultureLand,
    int? otherIfAny,
    List<ApplicantDto>? applicantDtos,
  }) =>
      SelectedJointApplicantDataData(
        hypothecationOfCrop: hypothecationOfCrop ?? this.hypothecationOfCrop,
        agrcultureLand: agrcultureLand ?? this.agrcultureLand,
        otherIfAny: otherIfAny ?? this.otherIfAny,
        applicantDtos: applicantDtos ?? this.applicantDtos,
      );

  factory SelectedJointApplicantDataData.fromJson(Map<String, dynamic> json) => SelectedJointApplicantDataData(
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
  int? farmerId;
  DateTime? dateOfBirth;
  String? genderName;
  String? joinApplicantName;
  String? idNumber;
  int? genderId;
  int? relationId;
  int? idProodId;
  String? relationName;
  String? idProodName;

  ApplicantDto({
    this.id,
    this.farmerId,
    this.dateOfBirth,
    this.genderName,
    this.joinApplicantName,
    this.idNumber,
    this.genderId,
    this.relationId,
    this.idProodId,
    this.relationName,
    this.idProodName,
  });

  ApplicantDto copyWith({
    int? id,
    int? farmerId,
    DateTime? dateOfBirth,
    String? genderName,
    String? joinApplicantName,
    String? idNumber,
    int? genderId,
    int? relationId,
    int? idProodId,
    String? relationName,
    String? idProodName,
  }) =>
      ApplicantDto(
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        genderName: genderName ?? this.genderName,
        joinApplicantName: joinApplicantName ?? this.joinApplicantName,
        idNumber: idNumber ?? this.idNumber,
        genderId: genderId ?? this.genderId,
        relationId: relationId ?? this.relationId,
        idProodId: idProodId ?? this.idProodId,
        relationName: relationName ?? this.relationName,
        idProodName: idProodName ?? this.idProodName,
      );

  factory ApplicantDto.fromJson(Map<String, dynamic> json) => ApplicantDto(
    id: json["id"],
    farmerId: json["farmerId"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    genderName: json["genderName"],
    joinApplicantName: json["joinApplicantName"],
    idNumber: json["idNumber"],
    genderId: json["genderId"],
    relationId: json["relationId"],
    idProodId: json["idProodId"],
    relationName: json["relationName"],
    idProodName: json["idProodName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "farmerId": farmerId,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "genderName": genderName,
    "joinApplicantName": joinApplicantName,
    "idNumber": idNumber,
    "genderId": genderId,
    "relationId": relationId,
    "idProodId": idProodId,
    "relationName": relationName,
    "idProodName": idProodName,
  };
}
