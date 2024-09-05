// To parse this JSON data, do
//
//     final loanDetailsNewPreviewResponseModel = loanDetailsNewPreviewResponseModelFromJson(jsonString);

import 'dart:convert';

LoanDetailsNewPreviewResponseModel loanDetailsNewPreviewResponseModelFromJson(
    String str) =>
    LoanDetailsNewPreviewResponseModel.fromJson(json.decode(str));

String loanDetailsNewPreviewResponseModelToJson(
    LoanDetailsNewPreviewResponseModel data) =>
    json.encode(data.toJson());

class LoanDetailsNewPreviewResponseModel {
  dynamic status;
  String? message;
  Data? data;
  dynamic dataList;

  LoanDetailsNewPreviewResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanDetailsNewPreviewResponseModel copyWith({
    dynamic status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      LoanDetailsNewPreviewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanDetailsNewPreviewResponseModel.fromJson(
      Map<String, dynamic> json) =>
      LoanDetailsNewPreviewResponseModel(
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
  LoanDetailMapper? loanDetailMapper;
  List<CropDetailDto>? cropDetailDtos;

  Data({
    this.loanDetailMapper,
    this.cropDetailDtos,
  });

  Data copyWith({
    LoanDetailMapper? loanDetailMapper,
    List<CropDetailDto>? cropDetailDtos,
  }) =>
      Data(
        loanDetailMapper: loanDetailMapper ?? this.loanDetailMapper,
        cropDetailDtos: cropDetailDtos ?? this.cropDetailDtos,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    loanDetailMapper: LoanDetailMapper.fromJson(json["loanDetailMapper"]),
    cropDetailDtos: List<CropDetailDto>.from(
        json["cropDetailDtos"].map((x) => CropDetailDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "loanDetailMapper": loanDetailMapper?.toJson(),
    "cropDetailDtos":
    List<dynamic>.from(cropDetailDtos!.map((x) => x.toJson())),
  };
}

class CropDetailDto {
  dynamic id;
  String? stateName;
  dynamic stateId;
  dynamic districtId;
  dynamic farmerId;
  dynamic area;
  String? landType;
  dynamic areaInAcre;
  dynamic bankSofId;
  dynamic croppingSeasonId;
  dynamic areaUnitId;
  dynamic loanId;
  String? districtName;
  String? croppingSeasonName;
  String? landTypeId;
  String? acreAmount;
  String? cropName;
  String? areaUnitValue;

  CropDetailDto({
    this.id,
    this.stateName,
    this.stateId,
    this.districtId,
    this.farmerId,
    this.area,
    this.landType,
    this.areaInAcre,
    this.bankSofId,
    this.croppingSeasonId,
    this.areaUnitId,
    this.loanId,
    this.districtName,
    this.croppingSeasonName,
    this.landTypeId,
    this.acreAmount,
    this.cropName,
    this.areaUnitValue,
  });

  CropDetailDto copyWith({
    dynamic id,
    String? stateName,
    dynamic stateId,
    dynamic districtId,
    dynamic farmerId,
    dynamic area,
    String? landType,
    dynamic areaInAcre,
    dynamic bankSofId,
    dynamic croppingSeasonId,
    dynamic areaUnitId,
    dynamic loanId,
    String? districtName,
    String? croppingSeasonName,
    String? landTypeId,
    String? acreAmount,
    String? cropName,
    String? areaUnitValue,
  }) =>
      CropDetailDto(
        id: id ?? this.id,
        stateName: stateName ?? this.stateName,
        stateId: stateId ?? this.stateId,
        districtId: districtId ?? this.districtId,
        farmerId: farmerId ?? this.farmerId,
        area: area ?? this.area,
        landType: landType ?? this.landType,
        areaInAcre: areaInAcre ?? this.areaInAcre,
        bankSofId: bankSofId ?? this.bankSofId,
        croppingSeasonId: croppingSeasonId ?? this.croppingSeasonId,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        loanId: loanId ?? this.loanId,
        districtName: districtName ?? this.districtName,
        croppingSeasonName: croppingSeasonName ?? this.croppingSeasonName,
        landTypeId: landTypeId ?? this.landTypeId,
        acreAmount: acreAmount ?? this.acreAmount,
        cropName: cropName ?? this.cropName,
        areaUnitValue: areaUnitValue ?? this.areaUnitValue,
      );

  factory CropDetailDto.fromJson(Map<String, dynamic> json) => CropDetailDto(
    id: json["id"],
    stateName: json["stateName"],
    stateId: json["stateId"],
    districtId: json["districtId"],
    farmerId: json["farmerId"],
    area: json["area"],
    landType: json["landType"],
    areaInAcre: json["areaInAcre"],
    bankSofId: json["bankSofId"],
    croppingSeasonId: json["croppingSeasonId"],
    areaUnitId: json["areaUnitId"],
    loanId: json["loanId"],
    districtName: json["districtName"],
    croppingSeasonName: json["croppingSeasonName"],
    landTypeId: json["landTypeId"],
    acreAmount: json["acreAmount"],
    cropName: json["cropName"],
    areaUnitValue: json["areaUnitValue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateName": stateName,
    "stateId": stateId,
    "districtId": districtId,
    "farmerId": farmerId,
    "area": area,
    "landType": landType,
    "areaInAcre": areaInAcre,
    "bankSofId": bankSofId,
    "croppingSeasonId": croppingSeasonId,
    "areaUnitId": areaUnitId,
    "loanId": loanId,
    "districtName": districtName,
    "croppingSeasonName": croppingSeasonName,
    "landTypeId": landTypeId,
    "acreAmount": acreAmount,
    "cropName": cropName,
    "areaUnitValue": areaUnitValue,
  };
}

class LoanDetailMapper {
  dynamic id;
  String? stateName;
  String? bankName;
  dynamic bankMasterId;
  dynamic entityLevelId;
  dynamic pacsLevelId;
  dynamic productMasterId;
  dynamic firstAmount;
  dynamic secondAmount;
  dynamic thirdAmount;
  dynamic totalAmount;
  dynamic stateMasterId;
  dynamic districtMasterId;
  dynamic loanStatusMasterId;
  dynamic userId;
  dynamic farmerId;
  String? bankType;
  String? loanPurpose;
  String? covered;
  dynamic agricultureIncome;
  dynamic alliedIncome;
  dynamic otherIncome;
  String? lastYear;
  dynamic totalLandAreaUnitId;
  dynamic totalLandAreaAcre;
  dynamic presentMarketValue;
  dynamic totalLandArea;
  String? entityLevelName;
  dynamic sanctionDate;
  dynamic loanAmount;
  String? loanNumber;
  dynamic sanctionAmount;
  dynamic isDeleted;
  dynamic pacsMember;
  dynamic pacsLevelName;
  dynamic pacsLoan;
  dynamic pacsCode;
  String? jointApplicant;
  dynamic existingLiabilities;
  dynamic guarantorOffered;
  dynamic guarantorLiabilities;
  dynamic otherSecurityDesc;
  String? districtName;
  dynamic pacsDetailId;
  dynamic parentEntityLevelId;

  LoanDetailMapper({
    this.id,
    this.stateName,
    this.bankName,
    this.bankMasterId,
    this.entityLevelId,
    this.pacsLevelId,
    this.productMasterId,
    this.firstAmount,
    this.secondAmount,
    this.thirdAmount,
    this.totalAmount,
    this.stateMasterId,
    this.districtMasterId,
    this.loanStatusMasterId,
    this.userId,
    this.farmerId,
    this.bankType,
    this.loanPurpose,
    this.covered,
    this.agricultureIncome,
    this.alliedIncome,
    this.otherIncome,
    this.lastYear,
    this.totalLandAreaUnitId,
    this.totalLandAreaAcre,
    this.presentMarketValue,
    this.totalLandArea,
    this.entityLevelName,
    this.sanctionDate,
    this.loanAmount,
    this.loanNumber,
    this.sanctionAmount,
    this.isDeleted,
    this.pacsMember,
    this.pacsLevelName,
    this.pacsLoan,
    this.pacsCode,
    this.jointApplicant,
    this.existingLiabilities,
    this.guarantorOffered,
    this.guarantorLiabilities,
    this.otherSecurityDesc,
    this.districtName,
    this.pacsDetailId,
    this.parentEntityLevelId,
  });

  LoanDetailMapper copyWith({
    dynamic id,
    String? stateName,
    String? bankName,
    dynamic bankMasterId,
    dynamic entityLevelId,
    dynamic pacsLevelId,
    dynamic productMasterId,
    dynamic firstAmount,
    dynamic secondAmount,
    dynamic thirdAmount,
    dynamic totalAmount,
    dynamic stateMasterId,
    dynamic districtMasterId,
    dynamic loanStatusMasterId,
    dynamic userId,
    dynamic farmerId,
    String? bankType,
    String? loanPurpose,
    String? covered,
    dynamic agricultureIncome,
    dynamic alliedIncome,
    dynamic otherIncome,
    String? lastYear,
    dynamic totalLandAreaUnitId,
    dynamic totalLandAreaAcre,
    dynamic presentMarketValue,
    dynamic totalLandArea,
    String? entityLevelName,
    dynamic sanctionDate,
    dynamic loanAmount,
    String? loanNumber,
    dynamic sanctionAmount,
    dynamic isDeleted,
    dynamic pacsMember,
    dynamic pacsLevelName,
    dynamic pacsLoan,
    dynamic pacsCode,
    String? jointApplicant,
    dynamic existingLiabilities,
    dynamic guarantorOffered,
    dynamic guarantorLiabilities,
    dynamic otherSecurityDesc,
    String? districtName,
    dynamic pacsDetailId,
    dynamic parentEntityLevelId,
  }) =>
      LoanDetailMapper(
        id: id ?? this.id,
        stateName: stateName ?? this.stateName,
        bankName: bankName ?? this.bankName,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        entityLevelId: entityLevelId ?? this.entityLevelId,
        pacsLevelId: pacsLevelId ?? this.pacsLevelId,
        productMasterId: productMasterId ?? this.productMasterId,
        firstAmount: firstAmount ?? this.firstAmount,
        secondAmount: secondAmount ?? this.secondAmount,
        thirdAmount: thirdAmount ?? this.thirdAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        loanStatusMasterId: loanStatusMasterId ?? this.loanStatusMasterId,
        userId: userId ?? this.userId,
        farmerId: farmerId ?? this.farmerId,
        bankType: bankType ?? this.bankType,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        covered: covered ?? this.covered,
        agricultureIncome: agricultureIncome ?? this.agricultureIncome,
        alliedIncome: alliedIncome ?? this.alliedIncome,
        otherIncome: otherIncome ?? this.otherIncome,
        lastYear: lastYear ?? this.lastYear,
        totalLandAreaUnitId: totalLandAreaUnitId ?? this.totalLandAreaUnitId,
        totalLandAreaAcre: totalLandAreaAcre ?? this.totalLandAreaAcre,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        totalLandArea: totalLandArea ?? this.totalLandArea,
        entityLevelName: entityLevelName ?? this.entityLevelName,
        sanctionDate: sanctionDate ?? this.sanctionDate,
        loanAmount: loanAmount ?? this.loanAmount,
        loanNumber: loanNumber ?? this.loanNumber,
        sanctionAmount: sanctionAmount ?? this.sanctionAmount,
        isDeleted: isDeleted ?? this.isDeleted,
        pacsMember: pacsMember ?? this.pacsMember,
        pacsLevelName: pacsLevelName ?? this.pacsLevelName,
        pacsLoan: pacsLoan ?? this.pacsLoan,
        pacsCode: pacsCode ?? this.pacsCode,
        jointApplicant: jointApplicant ?? this.jointApplicant,
        existingLiabilities: existingLiabilities ?? this.existingLiabilities,
        guarantorOffered: guarantorOffered ?? this.guarantorOffered,
        guarantorLiabilities: guarantorLiabilities ?? this.guarantorLiabilities,
        otherSecurityDesc: otherSecurityDesc ?? this.otherSecurityDesc,
        districtName: districtName ?? this.districtName,
        pacsDetailId: pacsDetailId ?? this.pacsDetailId,
        parentEntityLevelId: parentEntityLevelId ?? this.parentEntityLevelId,
      );

  factory LoanDetailMapper.fromJson(Map<String, dynamic> json) =>
      LoanDetailMapper(
        id: json["id"],
        stateName: json["stateName"],
        bankName: json["bankName"],
        bankMasterId: json["bankMasterId"],
        entityLevelId: json["entityLevelId"],
        pacsLevelId: json["pacsLevelId"],
        productMasterId: json["productMasterId"],
        firstAmount: json["firstAmount"],
        secondAmount: json["secondAmount"],
        thirdAmount: json["thirdAmount"],
        totalAmount: json["totalAmount"],
        stateMasterId: json["stateMasterId"],
        districtMasterId: json["districtMasterId"],
        loanStatusMasterId: json["loanStatusMasterId"],
        userId: json["userId"],
        farmerId: json["farmerId"],
        bankType: json["bankType"],
        loanPurpose: json["loanPurpose"],
        covered: json["covered"],
        agricultureIncome: json["agricultureIncome"],
        alliedIncome: json["alliedIncome"],
        otherIncome: json["otherIncome"],
        lastYear: json["lastYear"],
        totalLandAreaUnitId: json["totalLandAreaUnitId"],
        totalLandAreaAcre: json["totalLandAreaAcre"],
        presentMarketValue: json["presentMarketValue"],
        totalLandArea: json["totalLandArea"],
        entityLevelName: json["entityLevelName"],
        sanctionDate: json["sanctionDate"],
        loanAmount: json["loanAmount"],
        loanNumber: json["loanNumber"],
        sanctionAmount: json["sanctionAmount"],
        isDeleted: json["isDeleted"],
        pacsMember: json["pacsMember"],
        pacsLevelName: json["pacsLevelName"],
        pacsLoan: json["pacsLoan"],
        pacsCode: json["pacsCode"],
        jointApplicant: json["jointApplicant"],
        existingLiabilities: json["existingLiabilities"],
        guarantorOffered: json["guarantorOffered"],
        guarantorLiabilities: json["guarantorLiabilities"],
        otherSecurityDesc: json["otherSecurityDesc"],
        districtName: json["districtName"],
        pacsDetailId: json["pacsDetailId"],
        parentEntityLevelId: json["parentEntityLevelId"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateName": stateName,
    "bankName": bankName,
    "bankMasterId": bankMasterId,
    "entityLevelId": entityLevelId,
    "pacsLevelId": pacsLevelId,
    "productMasterId": productMasterId,
    "firstAmount": firstAmount,
    "secondAmount": secondAmount,
    "thirdAmount": thirdAmount,
    "totalAmount": totalAmount,
    "stateMasterId": stateMasterId,
    "districtMasterId": districtMasterId,
    "loanStatusMasterId": loanStatusMasterId,
    "userId": userId,
    "farmerId": farmerId,
    "bankType": bankType,
    "loanPurpose": loanPurpose,
    "covered": covered,
    "agricultureIncome": agricultureIncome,
    "alliedIncome": alliedIncome,
    "otherIncome": otherIncome,
    "lastYear": lastYear,
    "totalLandAreaUnitId": totalLandAreaUnitId,
    "totalLandAreaAcre": totalLandAreaAcre,
    "presentMarketValue": presentMarketValue,
    "totalLandArea": totalLandArea,
    "entityLevelName": entityLevelName,
    "sanctionDate": sanctionDate,
    "loanAmount": loanAmount,
    "loanNumber": loanNumber,
    "sanctionAmount": sanctionAmount,
    "isDeleted": isDeleted,
    "pacsMember": pacsMember,
    "pacsLevelName": pacsLevelName,
    "pacsLoan": pacsLoan,
    "pacsCode": pacsCode,
    "jointApplicant": jointApplicant,
    "existingLiabilities": existingLiabilities,
    "guarantorOffered": guarantorOffered,
    "guarantorLiabilities": guarantorLiabilities,
    "otherSecurityDesc": otherSecurityDesc,
    "districtName": districtName,
    "pacsDetailId": pacsDetailId,
    "parentEntityLevelId": parentEntityLevelId,
  };
}
