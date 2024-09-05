import 'dart:convert';

LoanBasicResponseModel loanBasicResponseModelFromJson(String str) => LoanBasicResponseModel.fromJson(json.decode(str));

String loanBasicResponseModelToJson(LoanBasicResponseModel data) => json.encode(data.toJson());

class LoanBasicResponseModel {
  int? status;
  String? message;
  LoanBasicData? data;
  dynamic dataList;

  LoanBasicResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanBasicResponseModel copyWith({
    int? status,
    String? message,
    LoanBasicData? data,
    dynamic dataList,
  }) =>
      LoanBasicResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanBasicResponseModel.fromJson(Map<String, dynamic> json) => LoanBasicResponseModel(
    status: json["status"],
    message: json["message"],
    data: LoanBasicData.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class LoanBasicData {
  LoanDetailMapper? loanDetailMapper;
  List<CropDetailDto>? cropDetailDtos;
  CalculateLoanLimit? calculateLoanLimit;

  LoanBasicData({
    this.loanDetailMapper,
    this.cropDetailDtos,
    this.calculateLoanLimit,
  });

  LoanBasicData copyWith({
    LoanDetailMapper? loanDetailMapper,
    List<CropDetailDto>? cropDetailDtos,
    CalculateLoanLimit? calculateLoanLimit,
  }) =>
      LoanBasicData(
        loanDetailMapper: loanDetailMapper ?? this.loanDetailMapper,
        cropDetailDtos: cropDetailDtos ?? this.cropDetailDtos,
        calculateLoanLimit: calculateLoanLimit ?? this.calculateLoanLimit,
      );

  factory LoanBasicData.fromJson(Map<String, dynamic> json) => LoanBasicData(
    loanDetailMapper: LoanDetailMapper.fromJson(json["loanDetailMapper"]),
    cropDetailDtos: List<CropDetailDto>.from(json["cropDetailDtos"].map((x) => CropDetailDto.fromJson(x))),
    calculateLoanLimit: CalculateLoanLimit.fromJson(json["calculateLoanLimit"]),
  );

  Map<String, dynamic> toJson() => {
    "loanDetailMapper": loanDetailMapper?.toJson(),
    "cropDetailDtos": List<dynamic>.from(cropDetailDtos!.map((x) => x.toJson())),
    "calculateLoanLimit": calculateLoanLimit?.toJson(),
  };
}

class CalculateLoanLimit {
  String? createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;
  int? id;
  dynamic costOfCultivation;
  dynamic familyConsumption;
  dynamic farmMaintenance;
  dynamic totalLoanAmount;
  int? loanMasterId;
  dynamic loanMaster;

  CalculateLoanLimit({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.costOfCultivation,
    this.familyConsumption,
    this.farmMaintenance,
    this.totalLoanAmount,
    this.loanMasterId,
    this.loanMaster,
  });

  CalculateLoanLimit copyWith({
    String? createdBy,
    DateTime? createdDate,
    String? lastModifiedBy,
    DateTime? lastModifiedDate,
    int? id,
    dynamic costOfCultivation,
    dynamic familyConsumption,
    dynamic farmMaintenance,
    dynamic totalLoanAmount,
    int? loanMasterId,
    dynamic loanMaster,
  }) =>
      CalculateLoanLimit(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        costOfCultivation: costOfCultivation ?? this.costOfCultivation,
        familyConsumption: familyConsumption ?? this.familyConsumption,
        farmMaintenance: farmMaintenance ?? this.farmMaintenance,
        totalLoanAmount: totalLoanAmount ?? this.totalLoanAmount,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        loanMaster: loanMaster ?? this.loanMaster,
      );

  factory CalculateLoanLimit.fromJson(Map<String, dynamic> json) => CalculateLoanLimit(
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
    id: json["id"],
    costOfCultivation: json["costOfCultivation"],
    familyConsumption: json["familyConsumption"],
    farmMaintenance: json["farmMaintenance"],
    totalLoanAmount: json["totalLoanAmount"],
    loanMasterId: json["loanMasterId"],
    loanMaster: json["loanMaster"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate?.toIso8601String(),
    "id": id,
    "costOfCultivation": costOfCultivation,
    "familyConsumption": familyConsumption,
    "farmMaintenance": farmMaintenance,
    "totalLoanAmount": totalLoanAmount,
    "loanMasterId": loanMasterId,
    "loanMaster": loanMaster,
  };
}

class CropDetailDto {
  int? id;
  String? stateName;
  int? bankSofId;
  int? croppingSeasonId;
  int? areaUnitId;
  dynamic area;
  String? croppingSeasonName;
  String? cropName;
  String? landType;
  String? districtName;
  int? farmerId;
  dynamic areaInAcre;
  int? stateId;
  int? districtId;
  int? loanId;
  String? landTypeId;
  String? acreAmount;
  String? areaUnitValue;

  CropDetailDto({
    this.id,
    this.stateName,
    this.bankSofId,
    this.croppingSeasonId,
    this.areaUnitId,
    this.area,
    this.croppingSeasonName,
    this.cropName,
    this.landType,
    this.districtName,
    this.farmerId,
    this.areaInAcre,
    this.stateId,
    this.districtId,
    this.loanId,
    this.landTypeId,
    this.acreAmount,
    this.areaUnitValue,
  });

  CropDetailDto copyWith({
    int? id,
    String? stateName,
    int? bankSofId,
    int? croppingSeasonId,
    int? areaUnitId,
    dynamic area,
    String? croppingSeasonName,
    String? cropName,
    String? landType,
    String? districtName,
    int? farmerId,
    dynamic areaInAcre,
    int? stateId,
    int? districtId,
    int? loanId,
    String? landTypeId,
    String? acreAmount,
    String? areaUnitValue,
  }) =>
      CropDetailDto(
        id: id ?? this.id,
        stateName: stateName ?? this.stateName,
        bankSofId: bankSofId ?? this.bankSofId,
        croppingSeasonId: croppingSeasonId ?? this.croppingSeasonId,
        areaUnitId: areaUnitId ?? this.areaUnitId,
        area: area ?? this.area,
        croppingSeasonName: croppingSeasonName ?? this.croppingSeasonName,
        cropName: cropName ?? this.cropName,
        landType: landType ?? this.landType,
        districtName: districtName ?? this.districtName,
        farmerId: farmerId ?? this.farmerId,
        areaInAcre: areaInAcre ?? this.areaInAcre,
        stateId: stateId ?? this.stateId,
        districtId: districtId ?? this.districtId,
        loanId: loanId ?? this.loanId,
        landTypeId: landTypeId ?? this.landTypeId,
        acreAmount: acreAmount ?? this.acreAmount,
        areaUnitValue: areaUnitValue ?? this.areaUnitValue,
      );

  factory CropDetailDto.fromJson(Map<String, dynamic> json) => CropDetailDto(
    id: json["id"],
    stateName: json["stateName"],
    bankSofId: json["bankSofId"],
    croppingSeasonId: json["croppingSeasonId"],
    areaUnitId: json["areaUnitId"],
    area: json["area"],
    croppingSeasonName: json["croppingSeasonName"],
    cropName: json["cropName"],
    landType: json["landType"],
    districtName: json["districtName"],
    farmerId: json["farmerId"],
    areaInAcre: json["areaInAcre"],
    stateId: json["stateId"],
    districtId: json["districtId"],
    loanId: json["loanId"],
    landTypeId: json["landTypeId"],
    acreAmount: json["acreAmount"],
    areaUnitValue: json["areaUnitValue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateName": stateName,
    "bankSofId": bankSofId,
    "croppingSeasonId": croppingSeasonId,
    "areaUnitId": areaUnitId,
    "area": area,
    "croppingSeasonName": croppingSeasonName,
    "cropName": cropName,
    "landType": landType,
    "districtName": districtName,
    "farmerId": farmerId,
    "areaInAcre": areaInAcre,
    "stateId": stateId,
    "districtId": districtId,
    "loanId": loanId,
    "landTypeId": landTypeId,
    "acreAmount": acreAmount,
    "areaUnitValue": areaUnitValue,
  };
}

class LoanDetailMapper {
  int? id;
  String? stateName;
  dynamic sanctionAmount;
  dynamic agricultureIncome;
  dynamic alliedIncome;
  dynamic otherIncome;
  dynamic lastYear;
  dynamic totalLandAreaUnitId;
  dynamic totalLandAreaAcre;
  dynamic presentMarketValue;
  dynamic totalLandArea;
  String? entityLevelName;
  String? districtName;
  String? bankName;
  dynamic productName;
  dynamic sanctionDate;
  dynamic loanAmount;
  String? loanNumber;
  int? loanStatusMasterId;
  int? farmerId;
  String? bankType;
  String? loanPurpose;
  String? covered;
  dynamic whereToApply;
  int? userId;
  int? entityLevelId;
  int? bankMasterId;
  int? productMasterId;
  dynamic firstAmount;
  dynamic secondAmount;
  dynamic thirdAmount;
  dynamic totalAmount;
  int? stateMasterId;
  int? districtMasterId;
  dynamic pacsLevelId;
  int? isDeleted;
  dynamic pacsDetailId;
  int? parentEntityLevelId;
  dynamic pacsLevelName;
  dynamic pacsMember;
  dynamic pacsLoan;
  dynamic pacsCode;
  dynamic jointApplicant;
  dynamic existingLiabilities;
  dynamic guarantorOffered;
  dynamic guarantorLiabilities;
  dynamic otherSecurityDesc;

  LoanDetailMapper({
    this.id,
    this.stateName,
    this.sanctionAmount,
    this.agricultureIncome,
    this.alliedIncome,
    this.otherIncome,
    this.lastYear,
    this.totalLandAreaUnitId,
    this.totalLandAreaAcre,
    this.presentMarketValue,
    this.totalLandArea,
    this.entityLevelName,
    this.districtName,
    this.bankName,
    this.productName,
    this.sanctionDate,
    this.loanAmount,
    this.loanNumber,
    this.loanStatusMasterId,
    this.farmerId,
    this.bankType,
    this.loanPurpose,
    this.covered,
    this.whereToApply,
    this.userId,
    this.entityLevelId,
    this.bankMasterId,
    this.productMasterId,
    this.firstAmount,
    this.secondAmount,
    this.thirdAmount,
    this.totalAmount,
    this.stateMasterId,
    this.districtMasterId,
    this.pacsLevelId,
    this.isDeleted,
    this.pacsDetailId,
    this.parentEntityLevelId,
    this.pacsLevelName,
    this.pacsMember,
    this.pacsLoan,
    this.pacsCode,
    this.jointApplicant,
    this.existingLiabilities,
    this.guarantorOffered,
    this.guarantorLiabilities,
    this.otherSecurityDesc,
  });

  LoanDetailMapper copyWith({
    int? id,
    String? stateName,
    dynamic sanctionAmount,
    dynamic agricultureIncome,
    dynamic alliedIncome,
    dynamic otherIncome,
    dynamic lastYear,
    dynamic totalLandAreaUnitId,
    dynamic totalLandAreaAcre,
    dynamic presentMarketValue,
    dynamic totalLandArea,
    String? entityLevelName,
    String? districtName,
    String? bankName,
    dynamic productName,
    dynamic sanctionDate,
    dynamic loanAmount,
    String? loanNumber,
    int? loanStatusMasterId,
    int? farmerId,
    String? bankType,
    String? loanPurpose,
    String? covered,
    dynamic whereToApply,
    int? userId,
    int? entityLevelId,
    int? bankMasterId,
    int? productMasterId,
    dynamic firstAmount,
    dynamic secondAmount,
    dynamic thirdAmount,
    dynamic totalAmount,
    int? stateMasterId,
    int? districtMasterId,
    dynamic pacsLevelId,
    int? isDeleted,
    dynamic pacsDetailId,
    int? parentEntityLevelId,
    dynamic pacsLevelName,
    dynamic pacsMember,
    dynamic pacsLoan,
    dynamic pacsCode,
    dynamic jointApplicant,
    dynamic existingLiabilities,
    dynamic guarantorOffered,
    dynamic guarantorLiabilities,
    dynamic otherSecurityDesc,
  }) =>
      LoanDetailMapper(
        id: id ?? this.id,
        stateName: stateName ?? this.stateName,
        sanctionAmount: sanctionAmount ?? this.sanctionAmount,
        agricultureIncome: agricultureIncome ?? this.agricultureIncome,
        alliedIncome: alliedIncome ?? this.alliedIncome,
        otherIncome: otherIncome ?? this.otherIncome,
        lastYear: lastYear ?? this.lastYear,
        totalLandAreaUnitId: totalLandAreaUnitId ?? this.totalLandAreaUnitId,
        totalLandAreaAcre: totalLandAreaAcre ?? this.totalLandAreaAcre,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        totalLandArea: totalLandArea ?? this.totalLandArea,
        entityLevelName: entityLevelName ?? this.entityLevelName,
        districtName: districtName ?? this.districtName,
        bankName: bankName ?? this.bankName,
        productName: productName ?? this.productName,
        sanctionDate: sanctionDate ?? this.sanctionDate,
        loanAmount: loanAmount ?? this.loanAmount,
        loanNumber: loanNumber ?? this.loanNumber,
        loanStatusMasterId: loanStatusMasterId ?? this.loanStatusMasterId,
        farmerId: farmerId ?? this.farmerId,
        bankType: bankType ?? this.bankType,
        loanPurpose: loanPurpose ?? this.loanPurpose,
        covered: covered ?? this.covered,
        whereToApply: whereToApply ?? this.whereToApply,
        userId: userId ?? this.userId,
        entityLevelId: entityLevelId ?? this.entityLevelId,
        bankMasterId: bankMasterId ?? this.bankMasterId,
        productMasterId: productMasterId ?? this.productMasterId,
        firstAmount: firstAmount ?? this.firstAmount,
        secondAmount: secondAmount ?? this.secondAmount,
        thirdAmount: thirdAmount ?? this.thirdAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        stateMasterId: stateMasterId ?? this.stateMasterId,
        districtMasterId: districtMasterId ?? this.districtMasterId,
        pacsLevelId: pacsLevelId ?? this.pacsLevelId,
        isDeleted: isDeleted ?? this.isDeleted,
        pacsDetailId: pacsDetailId ?? this.pacsDetailId,
        parentEntityLevelId: parentEntityLevelId ?? this.parentEntityLevelId,
        pacsLevelName: pacsLevelName ?? this.pacsLevelName,
        pacsMember: pacsMember ?? this.pacsMember,
        pacsLoan: pacsLoan ?? this.pacsLoan,
        pacsCode: pacsCode ?? this.pacsCode,
        jointApplicant: jointApplicant ?? this.jointApplicant,
        existingLiabilities: existingLiabilities ?? this.existingLiabilities,
        guarantorOffered: guarantorOffered ?? this.guarantorOffered,
        guarantorLiabilities: guarantorLiabilities ?? this.guarantorLiabilities,
        otherSecurityDesc: otherSecurityDesc ?? this.otherSecurityDesc,
      );

  factory LoanDetailMapper.fromJson(Map<String, dynamic> json) => LoanDetailMapper(
    id: json["id"],
    stateName: json["stateName"],
    sanctionAmount: json["sanctionAmount"],
    agricultureIncome: json["agricultureIncome"],
    alliedIncome: json["alliedIncome"],
    otherIncome: json["otherIncome"],
    lastYear: json["lastYear"],
    totalLandAreaUnitId: json["totalLandAreaUnitId"],
    totalLandAreaAcre: json["totalLandAreaAcre"],
    presentMarketValue: json["presentMarketValue"],
    totalLandArea: json["totalLandArea"],
    entityLevelName: json["entityLevelName"],
    districtName: json["districtName"],
    bankName: json["bankName"],
    productName: json["productName"],
    sanctionDate: json["sanctionDate"],
    loanAmount: json["loanAmount"],
    loanNumber: json["loanNumber"],
    loanStatusMasterId: json["loanStatusMasterId"],
    farmerId: json["farmerId"],
    bankType: json["bankType"],
    loanPurpose: json["loanPurpose"],
    covered: json["covered"],
    whereToApply: json["whereToApply"],
    userId: json["userId"],
    entityLevelId: json["entityLevelId"],
    bankMasterId: json["bankMasterId"],
    productMasterId: json["productMasterId"],
    firstAmount: json["firstAmount"],
    secondAmount: json["secondAmount"],
    thirdAmount: json["thirdAmount"],
    totalAmount: json["totalAmount"],
    stateMasterId: json["stateMasterId"],
    districtMasterId: json["districtMasterId"],
    pacsLevelId: json["pacsLevelId"],
    isDeleted: json["isDeleted"],
    pacsDetailId: json["pacsDetailId"],
    parentEntityLevelId: json["parentEntityLevelId"],
    pacsLevelName: json["pacsLevelName"],
    pacsMember: json["pacsMember"],
    pacsLoan: json["pacsLoan"],
    pacsCode: json["pacsCode"],
    jointApplicant: json["jointApplicant"],
    existingLiabilities: json["existingLiabilities"],
    guarantorOffered: json["guarantorOffered"],
    guarantorLiabilities: json["guarantorLiabilities"],
    otherSecurityDesc: json["otherSecurityDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateName": stateName,
    "sanctionAmount": sanctionAmount,
    "agricultureIncome": agricultureIncome,
    "alliedIncome": alliedIncome,
    "otherIncome": otherIncome,
    "lastYear": lastYear,
    "totalLandAreaUnitId": totalLandAreaUnitId,
    "totalLandAreaAcre": totalLandAreaAcre,
    "presentMarketValue": presentMarketValue,
    "totalLandArea": totalLandArea,
    "entityLevelName": entityLevelName,
    "districtName": districtName,
    "bankName": bankName,
    "productName": productName,
    "sanctionDate": sanctionDate,
    "loanAmount": loanAmount,
    "loanNumber": loanNumber,
    "loanStatusMasterId": loanStatusMasterId,
    "farmerId": farmerId,
    "bankType": bankType,
    "loanPurpose": loanPurpose,
    "covered": covered,
    "whereToApply": whereToApply,
    "userId": userId,
    "entityLevelId": entityLevelId,
    "bankMasterId": bankMasterId,
    "productMasterId": productMasterId,
    "firstAmount": firstAmount,
    "secondAmount": secondAmount,
    "thirdAmount": thirdAmount,
    "totalAmount": totalAmount,
    "stateMasterId": stateMasterId,
    "districtMasterId": districtMasterId,
    "pacsLevelId": pacsLevelId,
    "isDeleted": isDeleted,
    "pacsDetailId": pacsDetailId,
    "parentEntityLevelId": parentEntityLevelId,
    "pacsLevelName": pacsLevelName,
    "pacsMember": pacsMember,
    "pacsLoan": pacsLoan,
    "pacsCode": pacsCode,
    "jointApplicant": jointApplicant,
    "existingLiabilities": existingLiabilities,
    "guarantorOffered": guarantorOffered,
    "guarantorLiabilities": guarantorLiabilities,
    "otherSecurityDesc": otherSecurityDesc,
  };
}
