class AddLandResponseModel {
  int? status;
  String? message;
  DataLandList? data;
  Null? dataList;

  AddLandResponseModel({this.status, this.message, this.data, this.dataList});

  AddLandResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  DataLandList.fromJson(json['data']) : null;
    dataList = json['dataList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['dataList'] = dataList;
    return data;
  }
}

class DataLandList {
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  dynamic? id;
  dynamic? farmerId;
  dynamic? villageId;
  Null? ownership;
  int? ownershipId;
  String? ownershipName;
  Null? areaUnit;
  dynamic? areaUnitId;
  String? areaUnitName;
  Null? sourceOfIrrigation;
  dynamic? sourceOfIrrigationId;
  String? sourceOfIrrigationName;
  String? surveyNo;
  String? encumbered;
  dynamic area;
  double? irrigatedLand;
  double? unIrrigatedLand;
  Null? farmId;
  Null? landPdf;
  dynamic? isDeleted;
  dynamic? hobliCode;
  Null? talukNameKan;
  Null? surnoc;
  Null? hissano;
  dynamic? areaHectare;
  Null? publicLiablity;
  Null? governmentLiablity;
  Null? longitude;
  Null? latitude;
  dynamic? stateMasterId;
  dynamic? districtMasterId;
  String? villageName;
  String? districtName;
  String? stateName;

  DataLandList(
      {this.createdBy,
        this.createdDate,
        this.lastModifiedBy,
        this.lastModifiedDate,
        this.id,
        this.farmerId,
        this.villageId,
        this.ownership,
        this.ownershipId,
        this.ownershipName,
        this.areaUnit,
        this.areaUnitId,
        this.areaUnitName,
        this.sourceOfIrrigation,
        this.sourceOfIrrigationId,
        this.sourceOfIrrigationName,
        this.surveyNo,
        this.encumbered,
        this.area,
        this.irrigatedLand,
        this.unIrrigatedLand,
        this.farmId,
        this.landPdf,
        this.isDeleted,
        this.hobliCode,
        this.talukNameKan,
        this.surnoc,
        this.hissano,
        this.areaHectare,
        this.publicLiablity,
        this.governmentLiablity,
        this.longitude,
        this.latitude,
        this.stateMasterId,
        this.districtMasterId,
        this.villageName,
        this.districtName,
        this.stateName});

  DataLandList.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    farmerId = json['farmerId'];
    villageId = json['villageId'];
    ownership = json['ownership'];
    ownershipId = json['ownershipId'];
    ownershipName = json['ownershipName'];
    areaUnit = json['areaUnit'];
    areaUnitId = json['areaUnitId'];
    areaUnitName = json['areaUnitName'];
    sourceOfIrrigation = json['sourceOfIrrigation'];
    sourceOfIrrigationId = json['sourceOfIrrigationId'];
    sourceOfIrrigationName = json['sourceOfIrrigationName'];
    surveyNo = json['surveyNo'];
    encumbered = json['encumbered'];
    area = json['area'];
    irrigatedLand = json['irrigatedLand'];
    unIrrigatedLand = json['unIrrigatedLand'];
    farmId = json['farmId'];
    landPdf = json['landPdf'];
    isDeleted = json['isDeleted'];
    hobliCode = json['hobliCode'];
    talukNameKan = json['talukNameKan'];
    surnoc = json['surnoc'];
    hissano = json['hissano'];
    areaHectare = json['areaHectare'];
    publicLiablity = json['publicLiablity'];
    governmentLiablity = json['governmentLiablity'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    stateMasterId = json['stateMasterId'];
    districtMasterId = json['districtMasterId'];
    villageName = json['villageName'];
    districtName = json['districtName'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lastModifiedDate'] = lastModifiedDate;
    data['id'] = id;
    data['farmerId'] = farmerId;
    data['villageId'] = villageId;
    data['ownership'] = ownership;
    data['ownershipId'] = ownershipId;
    data['ownershipName'] = ownershipName;
    data['areaUnit'] = areaUnit;
    data['areaUnitId'] = areaUnitId;
    data['areaUnitName'] = areaUnitName;
    data['sourceOfIrrigation'] = sourceOfIrrigation;
    data['sourceOfIrrigationId'] = sourceOfIrrigationId;
    data['sourceOfIrrigationName'] = sourceOfIrrigationName;
    data['surveyNo'] = surveyNo;
    data['encumbered'] = encumbered;
    data['area'] = area;
    data['irrigatedLand'] = irrigatedLand;
    data['unIrrigatedLand'] = unIrrigatedLand;
    data['farmId'] = farmId;
    data['landPdf'] = landPdf;
    data['isDeleted'] = isDeleted;
    data['hobliCode'] = hobliCode;
    data['talukNameKan'] = talukNameKan;
    data['surnoc'] = surnoc;
    data['hissano'] = hissano;
    data['areaHectare'] = areaHectare;
    data['publicLiablity'] = publicLiablity;
    data['governmentLiablity'] = governmentLiablity;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['stateMasterId'] = stateMasterId;
    data['districtMasterId'] = districtMasterId;
    data['villageName'] = villageName;
    data['districtName'] = districtName;
    data['stateName'] = stateName;
    return data;
  }
}
