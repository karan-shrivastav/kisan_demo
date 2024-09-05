
class CropDetailDtos {
  dynamic id;
  String? stateName;
  dynamic farmerId;
  dynamic areaInAcre;
  dynamic area;
  String? landType;
  dynamic bankSofId;
  dynamic croppingSeasonId;
  dynamic areaUnitId;
  dynamic loanId;
  dynamic stateId;
  dynamic districtId;
  String? districtName;
  String? croppingSeasonName;
  String? landTypeId;
  String? acreAmount;
  String? cropName;
  String? areaUnitValue;

  CropDetailDtos(
      {this.id,
        this.stateName,
        this.farmerId,
        this.areaInAcre,
        this.area,
        this.landType,
        this.bankSofId,
        this.croppingSeasonId,
        this.areaUnitId,
        this.loanId,
        this.stateId,
        this.districtId,
        this.districtName,
        this.croppingSeasonName,
        this.landTypeId,
        this.acreAmount,
        this.cropName,
        this.areaUnitValue});

  CropDetailDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['stateName'];
    farmerId = json['farmerId'];
    areaInAcre = json['areaInAcre'];
    area = json['area'];
    landType = json['landType'];
    bankSofId = json['bankSofId'];
    croppingSeasonId = json['croppingSeasonId'];
    areaUnitId = json['areaUnitId'];
    loanId = json['loanId'];
    stateId = json['stateId'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    croppingSeasonName = json['croppingSeasonName'];
    landTypeId = json['landTypeId'];
    acreAmount = json['acreAmount'];
    cropName = json['cropName'];
    areaUnitValue = json['areaUnitValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['stateName'] = stateName;
    data['farmerId'] = farmerId;
    data['areaInAcre'] = areaInAcre;
    data['area'] = area;
    data['landType'] = landType;
    data['bankSofId'] = bankSofId;
    data['croppingSeasonId'] = croppingSeasonId;
    data['areaUnitId'] = areaUnitId;
    data['loanId'] = loanId;
    data['stateId'] = stateId;
    data['districtId'] = districtId;
    data['districtName'] = districtName;
    data['croppingSeasonName'] = croppingSeasonName;
    data['landTypeId'] = landTypeId;
    data['acreAmount'] = acreAmount;
    data['cropName'] = cropName;
    data['areaUnitValue'] = areaUnitValue;
    return data;
  }
}
