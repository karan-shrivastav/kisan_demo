// To parse this JSON data, do
//
//     final saveCropResponseModel = saveCropResponseModelFromJson(jsonString);

import 'dart:convert';

SaveCropResponseModel saveCropResponseModelFromJson(String str) =>
    SaveCropResponseModel.fromJson(json.decode(str));

String saveCropResponseModelToJson(SaveCropResponseModel data) =>
    json.encode(data.toJson());

class SaveCropResponseModel {
  int? status;
  String? message;
  Data? data;
  dynamic dataList;

  SaveCropResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  SaveCropResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      SaveCropResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory SaveCropResponseModel.fromJson(Map<String, dynamic> json) =>
      SaveCropResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        dataList: json["dataList"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
    "dataList": dataList,
  };
}

class Data {
  List<UserProposedDetail>? userProposedDetails;
  LoanMasterRequestPayload? loanMasterRequestPayload;
  dynamic loanSanctionNote;
  dynamic loanMasterLandDetailsRequestPayload;

  Data({
    this.userProposedDetails,
    this.loanMasterRequestPayload,
    this.loanSanctionNote,
    this.loanMasterLandDetailsRequestPayload,
  });

  Data copyWith({
    List<UserProposedDetail>? userProposedDetails,
    LoanMasterRequestPayload? loanMasterRequestPayload,
    dynamic loanSanctionNote,
    dynamic loanMasterLandDetailsRequestPayload,
  }) =>
      Data(
        userProposedDetails: userProposedDetails ?? this.userProposedDetails,
        loanMasterRequestPayload:
        loanMasterRequestPayload ?? this.loanMasterRequestPayload,
        loanSanctionNote: loanSanctionNote ?? this.loanSanctionNote,
        loanMasterLandDetailsRequestPayload:
        loanMasterLandDetailsRequestPayload ??
            this.loanMasterLandDetailsRequestPayload,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userProposedDetails: List<UserProposedDetail>.from(
        json["userProposedDetails"]
            .map((x) => UserProposedDetail.fromJson(x))),
    loanMasterRequestPayload:
    LoanMasterRequestPayload.fromJson(json["loanMasterRequestPayload"]),
    loanSanctionNote: json["loanSanctionNote"],
    loanMasterLandDetailsRequestPayload:
    json["loanMasterLandDetailsRequestPayload"],
  );

  Map<String, dynamic> toJson() => {
    "userProposedDetails":
    List<dynamic>.from(userProposedDetails!.map((x) => x.toJson())),
    "loanMasterRequestPayload": loanMasterRequestPayload!.toJson(),
    "loanSanctionNote": loanSanctionNote,
    "loanMasterLandDetailsRequestPayload":
    loanMasterLandDetailsRequestPayload,
  };
}

class LoanMasterRequestPayload {
  dynamic id;
  dynamic farmerId;
  dynamic productMasterId;
  dynamic loanNumber;
  dynamic bankMasterId;
  dynamic entityLevelId;
  dynamic pacsLevelId;
  dynamic firstAmount;
  dynamic secondAmount;
  dynamic thirdAmount;
  dynamic totalAmount;
  dynamic loanPurpose;
  dynamic covered;

  LoanMasterRequestPayload({
    this.id,
    this.farmerId,
    this.productMasterId,
    this.loanNumber,
    this.bankMasterId,
    this.entityLevelId,
    this.pacsLevelId,
    this.firstAmount,
    this.secondAmount,
    this.thirdAmount,
    this.totalAmount,
    this.loanPurpose,
    this.covered,
  });

  LoanMasterRequestPayload copyWith({
    int? id,
    int? farmerId,
    int? productMasterId,
    dynamic loanNumber,
    int? bankMasterId,
    int? entityLevelId,
    dynamic pacsLevelId,
    double? firstAmount,
    double? secondAmount,
    double? thirdAmount,
    double? totalAmount,
    String? loanPurpose,
    String? covered,
  }) =>
      LoanMasterRequestPayload(
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        productMasterId: productMasterId ?? this.productMasterId,
        loanNumber: loanNumber ?? this.loanNumber,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        entityLevelId: entityLevelId ?? this.entityLevelId,
        pacsLevelId: pacsLevelId ?? this.pacsLevelId,
        firstAmount: firstAmount ?? this.firstAmount,
        secondAmount: secondAmount ?? this.secondAmount,
        thirdAmount: thirdAmount ?? this.thirdAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        covered: covered ?? this.covered,
      );

  factory LoanMasterRequestPayload.fromJson(Map<String, dynamic> json) =>
      LoanMasterRequestPayload(
        id: json["id"],
        farmerId: json["farmerId"],
        productMasterId: json["productMasterId"],
        loanNumber: json["loanNumber"],
        bankMasterId: json["bankMasterId"],
        entityLevelId: json["entityLevelId"],
        pacsLevelId: json["pacsLevelId"],
        firstAmount: json["firstAmount"].toDouble(),
        secondAmount: json["secondAmount"].toDouble(),
        thirdAmount: json["thirdAmount"].toDouble(),
        totalAmount: json["totalAmount"].toDouble(),
        loanPurpose: json["loanPurpose"],
        covered: json["covered"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "farmerId": farmerId,
    "productMasterId": productMasterId,
    "loanNumber": loanNumber,
    "bankMasterId": bankMasterId,
    "entityLevelId": entityLevelId,
    "pacsLevelId": pacsLevelId,
    "firstAmount": firstAmount,
    "secondAmount": secondAmount,
    "thirdAmount": thirdAmount,
    "totalAmount": totalAmount,
    "loanPurpose": loanPurpose,
    "covered": covered,
  };
}

class UserProposedDetail {
  dynamic createdBy;
  DateTime? createdDate;
  dynamic lastModifiedBy;
  DateTime? lastModifiedDate;
  dynamic id;
  dynamic farmerId;
  dynamic districtId;
  dynamic districtName;
  dynamic loanId;
  dynamic croppingSeason;
  dynamic croppingSeasonId;
  dynamic croppingSeasonName;
  dynamic areaUnit;
  dynamic areaUnitId;
  dynamic areaUnitName;
  double? area;
  dynamic areaInAcre;
  dynamic landTypeId;
  dynamic landType;
  String? acreAmount;
  dynamic stateMasterId;
  dynamic stateName;
  dynamic scaleOfFinanceProductMasterId;
  dynamic bankSofId;
  dynamic cropName;

  UserProposedDetail({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.farmerId,
    this.districtId,
    this.districtName,
    this.loanId,
    this.croppingSeason,
    this.croppingSeasonId,
    this.croppingSeasonName,
    this.areaUnit,
    this.areaUnitId,
    this.areaUnitName,
    this.area,
    this.areaInAcre,
    this.landTypeId,
    this.landType,
    this.acreAmount,
    this.stateMasterId,
    this.stateName,
    this.scaleOfFinanceProductMasterId,
    this.bankSofId,
    this.cropName,
  });

  UserProposedDetail copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    int? farmerId,
    int? districtId,
    dynamic districtName,
    int? loanId,
    dynamic croppingSeason,
    int? croppingSeasonId,
    dynamic croppingSeasonName,
    dynamic areaUnit,
    int? areaUnitId,
    dynamic areaUnitName,
    double? area,
    int? areaInAcre,
    dynamic landTypeId,
    String? landType,
    String? acreAmount,
    int? stateMasterId,
    dynamic stateName,
    int? scaleOfFinanceProductMasterId,
    int? bankSofId,
    dynamic cropName,
  }) =>
      UserProposedDetail(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        farmerId: farmerId ?? this.farmerId,
        districtId: districtId ?? this.districtId,
        districtName: districtName ?? this.districtName,
        loanId: loanId ?? this.loanId,
        croppingSeason: croppingSeason ?? this.croppingSeason,
        croppingSeasonId: croppingSeasonId ?? this.croppingSeasonId,
        croppingSeasonName: croppingSeasonName ?? this.croppingSeasonName,
        areaUnit: areaUnit ?? this.areaUnit,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        areaUnitName: areaUnitName ?? this.areaUnitName,
        area: area ?? this.area,
        areaInAcre: areaInAcre ?? this.areaInAcre,
        landTypeId: landTypeId ?? this.landTypeId,
        landType: landType ?? this.landType,
        acreAmount: acreAmount ?? this.acreAmount,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        stateName: stateName ?? this.stateName,
        scaleOfFinanceProductMasterId:
        scaleOfFinanceProductMasterId ?? this.scaleOfFinanceProductMasterId,
        bankSofId: bankSofId ?? this.bankSofId,
        cropName: cropName ?? this.cropName,
      );

  factory UserProposedDetail.fromJson(Map<String, dynamic> json) =>
      UserProposedDetail(
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        farmerId: json["farmerId"],
        districtId: json["districtId"],
        districtName: json["districtName"],
        loanId: json["loanId"],
        croppingSeason: json["croppingSeason"],
        croppingSeasonId: json["croppingSeasonId"],
        croppingSeasonName: json["croppingSeasonName"],
        areaUnit: json["areaUnit"],
        areaUnitId: json["areaUnitId"],
        areaUnitName: json["areaUnitName"],
        area: json["area"].toDouble(),
        areaInAcre: json["areaInAcre"],
        landTypeId: json["landTypeId"],
        landType: json["landType"],
        acreAmount: json["acreAmount"],
        stateMasterId: json["stateMasterId"],
        stateName: json["stateName"],
        scaleOfFinanceProductMasterId: json["scaleOfFinanceProductMasterId"],
        bankSofId: json["bankSofId"],
        cropName: json["cropName"],
      );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate!.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate!.toIso8601String(),
    "id": id,
    "farmerId": farmerId,
    "districtId": districtId,
    "districtName": districtName,
    "loanId": loanId,
    "croppingSeason": croppingSeason,
    "croppingSeasonId": croppingSeasonId,
    "croppingSeasonName": croppingSeasonName,
    "areaUnit": areaUnit,
    "areaUnitId": areaUnitId,
    "areaUnitName": areaUnitName,
    "area": area,
    "areaInAcre": areaInAcre,
    "landTypeId": landTypeId,
    "landType": landType,
    "acreAmount": acreAmount,
    "stateMasterId": stateMasterId,
    "stateName": stateName,
    "scaleOfFinanceProductMasterId": scaleOfFinanceProductMasterId,
    "bankSofId": bankSofId,
    "cropName": cropName,
  };
}
