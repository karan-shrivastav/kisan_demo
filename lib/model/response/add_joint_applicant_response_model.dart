import 'dart:convert';

AddJointApplicantResponseModel addJointApplicantResponseModelFromJson(String str) => AddJointApplicantResponseModel.fromJson(json.decode(str));

String addJointApplicantResponseModelToJson(AddJointApplicantResponseModel data) => json.encode(data.toJson());

class AddJointApplicantResponseModel {
  int? status;
  String? message;
  JointApplicantData? data;
  dynamic dataList;

  AddJointApplicantResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  AddJointApplicantResponseModel copyWith({
    int? status,
    String? message,
    JointApplicantData? data,
    dynamic dataList,
  }) =>
      AddJointApplicantResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory AddJointApplicantResponseModel.fromJson(Map<String, dynamic> json) => AddJointApplicantResponseModel(
    status: json["status"],
    message: json["message"],
    data: JointApplicantData.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class JointApplicantData {
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  int? id;
  int? farmerId;
  dynamic gender;
  int? genderId;
  String? genderName;
  dynamic relation;
  int? relationId;
  String? relationName;
  dynamic idProof;
  int? idProodId;
  String? idProofName;
  String? joinApplicantName;
  DateTime? dateOfBirth;
  String? idNumber;
  int? isDeleted;

  JointApplicantData({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.farmerId,
    this.gender,
    this.genderId,
    this.genderName,
    this.relation,
    this.relationId,
    this.relationName,
    this.idProof,
    this.idProodId,
    this.idProofName,
    this.joinApplicantName,
    this.dateOfBirth,
    this.idNumber,
    this.isDeleted,
  });

  JointApplicantData copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    int? farmerId,
    dynamic gender,
    int? genderId,
    String? genderName,
    dynamic relation,
    int? relationId,
    String? relationName,
    dynamic idProof,
    int? idProodId,
    String? idProofName,
    String? joinApplicantName,
    DateTime? dateOfBirth,
    String? idNumber,
    int? isDeleted,
  }) =>
      JointApplicantData(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        gender: gender ?? this.gender,
        genderId: genderId ?? this.genderId,
        genderName: genderName ?? this.genderName,
        relation: relation ?? this.relation,
        relationId: relationId ?? this.relationId,
        relationName: relationName ?? this.relationName,
        idProof: idProof ?? this.idProof,
        idProodId: idProodId ?? this.idProodId,
        idProofName: idProofName ?? this.idProofName,
        joinApplicantName: joinApplicantName ?? this.joinApplicantName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        idNumber: idNumber ?? this.idNumber,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory JointApplicantData.fromJson(Map<String, dynamic> json) => JointApplicantData(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    farmerId: json["farmerId"],
    gender: json["gender"],
    genderId: json["genderId"],
    genderName: json["genderName"],
    relation: json["relation"],
    relationId: json["relationId"],
    relationName: json["relationName"],
    idProof: json["idProof"],
    idProodId: json["idProodId"],
    idProofName: json["idProofName"],
    joinApplicantName: json["joinApplicantName"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    idNumber: json["idNumber"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "farmerId": farmerId,
    "gender": gender,
    "genderId": genderId,
    "genderName": genderName,
    "relation": relation,
    "relationId": relationId,
    "relationName": relationName,
    "idProof": idProof,
    "idProodId": idProodId,
    "idProofName": idProofName,
    "joinApplicantName": joinApplicantName,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "idNumber": idNumber,
    "isDeleted": isDeleted,
  };
}
