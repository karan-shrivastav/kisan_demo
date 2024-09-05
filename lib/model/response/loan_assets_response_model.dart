import 'dart:convert';

LoanAssetsResponseModel loanAssetsResponseModelFromJson(String str) => LoanAssetsResponseModel.fromJson(json.decode(str));

String loanAssetsResponseModelToJson(LoanAssetsResponseModel data) => json.encode(data.toJson());

class LoanAssetsResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<LoanAssetDataList>? dataList;

  LoanAssetsResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  LoanAssetsResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<LoanAssetDataList>? dataList,
  }) =>
      LoanAssetsResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory LoanAssetsResponseModel.fromJson(Map<String, dynamic> json) => LoanAssetsResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    dataList: List<LoanAssetDataList>.from(json["dataList"].map((x) => LoanAssetDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class LoanAssetDataList {
  int? id;
  int? loanMasterId;
  String? particulars;
  String? assetDataName;
  double? presentMarketValue;
  int? assetDataId;
  int? assestTypeId;
  dynamic assestTypeName;

  LoanAssetDataList({
    this.id,
    this.loanMasterId,
    this.particulars,
    this.assetDataName,
    this.presentMarketValue,
    this.assetDataId,
    this.assestTypeId,
    this.assestTypeName,
  });

  LoanAssetDataList copyWith({
    int? id,
    int? loanMasterId,
    String? particulars,
    String? assetDataName,
    double? presentMarketValue,
    int? assetDataId,
    int? assestTypeId,
    dynamic assestTypeName,
  }) =>
      LoanAssetDataList(
        id: id ?? this.id,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        particulars: particulars ?? this.particulars,
        assetDataName: assetDataName ?? this.assetDataName,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        assetDataId: assetDataId ?? this.assetDataId,
        assestTypeId: assestTypeId ?? this.assestTypeId,
        assestTypeName: assestTypeName ?? this.assestTypeName,
      );

  factory LoanAssetDataList.fromJson(Map<String, dynamic> json) => LoanAssetDataList(
    id: json["id"],
    loanMasterId: json["loanMasterId"],
    particulars: json["particulars"],
    assetDataName: json["assetDataName"],
    presentMarketValue: json["presentMarketValue"],
    assetDataId: json["assetDataId"],
    assestTypeId: json["assestTypeId"],
    assestTypeName: json["assestTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loanMasterId": loanMasterId,
    "particulars": particulars,
    "assetDataName": assetDataName,
    "presentMarketValue": presentMarketValue,
    "assetDataId": assetDataId,
    "assestTypeId": assestTypeId,
    "assestTypeName": assestTypeName,
  };
}
