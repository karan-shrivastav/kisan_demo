import 'dart:convert';

GetJointApplicantResponseModel getJointApplicantResponseModelFromJson(String str) => GetJointApplicantResponseModel.fromJson(json.decode(str));

String getJointApplicantResponseModelToJson(GetJointApplicantResponseModel data) => json.encode(data.toJson());

class GetJointApplicantResponseModel {
  int? status;
  String? message;
  JointApplicantData? data;
  dynamic dataList;

  GetJointApplicantResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetJointApplicantResponseModel copyWith({
    int? status,
    String? message,
    JointApplicantData? data,
    dynamic dataList,
  }) =>
      GetJointApplicantResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetJointApplicantResponseModel.fromJson(Map<String, dynamic> json) => GetJointApplicantResponseModel(
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
  List<Content>? content;
  int? numberOfPages;
  dynamic numOfLedDistributed;
  int? numberOfTotalElements;
  dynamic others;

  JointApplicantData({
    this.content,
    this.numberOfPages,
    this.numOfLedDistributed,
    this.numberOfTotalElements,
    this.others,
  });

  JointApplicantData copyWith({
    List<Content>? content,
    int? numberOfPages,
    dynamic numOfLedDistributed,
    int? numberOfTotalElements,
    dynamic others,
  }) =>
      JointApplicantData(
        content: content ?? this.content,
        numberOfPages: numberOfPages ?? this.numberOfPages,
        numOfLedDistributed: numOfLedDistributed ?? this.numOfLedDistributed,
        numberOfTotalElements: numberOfTotalElements ?? this.numberOfTotalElements,
        others: others ?? this.others,
      );

  factory JointApplicantData.fromJson(Map<String, dynamic> json) => JointApplicantData(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    numberOfPages: json["numberOfPages"],
    numOfLedDistributed: json["numOfLedDistributed"],
    numberOfTotalElements: json["numberOfTotalElements"],
    others: json["others"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "numberOfPages": numberOfPages,
    "numOfLedDistributed": numOfLedDistributed,
    "numberOfTotalElements": numberOfTotalElements,
    "others": others,
  };
}

class Content {
  dynamic createdBy;
  DateTime? createdDate;
  dynamic lastModifiedBy;
  DateTime? lastModifiedDate;
  int? id;
  int? farmerId;
  Gender? gender;
  int? genderId;
  String? genderName;
  Gender? relation;
  int? relationId;
  String? relationName;
  Gender? idProof;
  int? idProodId;
  String? idProofName;
  String? joinApplicantName;
  DateTime? dateOfBirth;
  String? idNumber;
  dynamic isDeleted;

  Content({
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

  Content copyWith({
    dynamic createdBy,
    DateTime? createdDate,
    dynamic lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    int? farmerId,
    Gender? gender,
    int? genderId,
    String? genderName,
    Gender? relation,
    int? relationId,
    String? relationName,
    Gender? idProof,
    int? idProodId,
    String? idProofName,
    String? joinApplicantName,
    DateTime? dateOfBirth,
    String? idNumber,
    dynamic isDeleted,
  }) =>
      Content(
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

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    farmerId: json["farmerId"],
    gender: Gender.fromJson(json["gender"]),
    genderId: json["genderId"],
    genderName: json["genderName"],
    relation: Gender.fromJson(json["relation"]),
    relationId: json["relationId"],
    relationName: json["relationName"],
    idProof: Gender.fromJson(json["idProof"]),
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
    "gender": gender?.toJson(),
    "genderId": genderId,
    "genderName": genderName,
    "relation": relation?.toJson(),
    "relationId": relationId,
    "relationName": relationName,
    "idProof": idProof?.toJson(),
    "idProodId": idProodId,
    "idProofName": idProofName,
    "joinApplicantName": joinApplicantName,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "idNumber": idNumber,
    "isDeleted": isDeleted,
  };
}

class Gender {
  dynamic createdBy;
  DateTime? createdDate;
  dynamic lastModifiedBy;
  DateTime? lastModifiedDate;
  int? id;
  dynamic parLovType;
  dynamic lovType;
  String? value;
  dynamic priority;
  int? isDeleted;
  dynamic comment;
  dynamic valueHindi;
  dynamic valueEnglish;
  dynamic valueGujrati;
  dynamic valueBengali;
  dynamic valuePanjabi;
  dynamic valueSanskrit;
  dynamic valueAssamese;
  dynamic valueKannada;
  dynamic valueKashmiri;
  dynamic valueKonkani;
  dynamic valueMalayalam;
  dynamic valueMarathi;
  dynamic valueNepali;
  dynamic valueOdia;
  dynamic valueTamil;
  dynamic valueTelugu;
  dynamic valueUrdu;
  dynamic valueCode;

  Gender({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.parLovType,
    this.lovType,
    this.value,
    this.priority,
    this.isDeleted,
    this.comment,
    this.valueHindi,
    this.valueEnglish,
    this.valueGujrati,
    this.valueBengali,
    this.valuePanjabi,
    this.valueSanskrit,
    this.valueAssamese,
    this.valueKannada,
    this.valueKashmiri,
    this.valueKonkani,
    this.valueMalayalam,
    this.valueMarathi,
    this.valueNepali,
    this.valueOdia,
    this.valueTamil,
    this.valueTelugu,
    this.valueUrdu,
    this.valueCode,
  });

  Gender copyWith({
    dynamic createdBy,
    DateTime? createdDate,
    dynamic lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    dynamic parLovType,
    dynamic lovType,
    String? value,
    dynamic priority,
    int? isDeleted,
    dynamic comment,
    dynamic valueHindi,
    dynamic valueEnglish,
    dynamic valueGujrati,
    dynamic valueBengali,
    dynamic valuePanjabi,
    dynamic valueSanskrit,
    dynamic valueAssamese,
    dynamic valueKannada,
    dynamic valueKashmiri,
    dynamic valueKonkani,
    dynamic valueMalayalam,
    dynamic valueMarathi,
    dynamic valueNepali,
    dynamic valueOdia,
    dynamic valueTamil,
    dynamic valueTelugu,
    dynamic valueUrdu,
    dynamic valueCode,
  }) =>
      Gender(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        parLovType: parLovType ?? this.parLovType,
        lovType: lovType ?? this.lovType,
        value: value ?? this.value,
        priority: priority ?? this.priority,
        isDeleted: isDeleted ?? this.isDeleted,
        comment: comment ?? this.comment,
        valueHindi: valueHindi ?? this.valueHindi,
        valueEnglish: valueEnglish ?? this.valueEnglish,
        valueGujrati: valueGujrati ?? this.valueGujrati,
        valueBengali: valueBengali ?? this.valueBengali,
        valuePanjabi: valuePanjabi ?? this.valuePanjabi,
        valueSanskrit: valueSanskrit ?? this.valueSanskrit,
        valueAssamese: valueAssamese ?? this.valueAssamese,
        valueKannada: valueKannada ?? this.valueKannada,
        valueKashmiri: valueKashmiri ?? this.valueKashmiri,
        valueKonkani: valueKonkani ?? this.valueKonkani,
        valueMalayalam: valueMalayalam ?? this.valueMalayalam,
        valueMarathi: valueMarathi ?? this.valueMarathi,
        valueNepali: valueNepali ?? this.valueNepali,
        valueOdia: valueOdia ?? this.valueOdia,
        valueTamil: valueTamil ?? this.valueTamil,
        valueTelugu: valueTelugu ?? this.valueTelugu,
        valueUrdu: valueUrdu ?? this.valueUrdu,
        valueCode: valueCode ?? this.valueCode,
      );

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    parLovType: json["parLovType"],
    lovType: json["lovType"],
    value: json["value"],
    priority: json["priority"],
    isDeleted: json["isDeleted"],
    comment: json["comment"],
    valueHindi: json["valueHindi"],
    valueEnglish: json["valueEnglish"],
    valueGujrati: json["valueGujrati"],
    valueBengali: json["valueBengali"],
    valuePanjabi: json["valuePanjabi"],
    valueSanskrit: json["valueSanskrit"],
    valueAssamese: json["valueAssamese"],
    valueKannada: json["valueKannada"],
    valueKashmiri: json["valueKashmiri"],
    valueKonkani: json["valueKonkani"],
    valueMalayalam: json["valueMalayalam"],
    valueMarathi: json["valueMarathi"],
    valueNepali: json["valueNepali"],
    valueOdia: json["valueOdia"],
    valueTamil: json["valueTamil"],
    valueTelugu: json["valueTelugu"],
    valueUrdu: json["valueUrdu"],
    valueCode: json["valueCode"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "parLovType": parLovType,
    "lovType": lovType,
    "value": value,
    "priority": priority,
    "isDeleted": isDeleted,
    "comment": comment,
    "valueHindi": valueHindi,
    "valueEnglish": valueEnglish,
    "valueGujrati": valueGujrati,
    "valueBengali": valueBengali,
    "valuePanjabi": valuePanjabi,
    "valueSanskrit": valueSanskrit,
    "valueAssamese": valueAssamese,
    "valueKannada": valueKannada,
    "valueKashmiri": valueKashmiri,
    "valueKonkani": valueKonkani,
    "valueMalayalam": valueMalayalam,
    "valueMarathi": valueMarathi,
    "valueNepali": valueNepali,
    "valueOdia": valueOdia,
    "valueTamil": valueTamil,
    "valueTelugu": valueTelugu,
    "valueUrdu": valueUrdu,
    "valueCode": valueCode,
  };
}
