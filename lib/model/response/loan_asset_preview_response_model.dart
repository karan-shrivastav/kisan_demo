// To parse this JSON data, do
//
//     final getLoanAssetNewPreviewResponseModel = getLoanAssetNewPreviewResponseModelFromJson(jsonString);

import 'dart:convert';

GetLoanAssetNewPreviewResponseModel getLoanAssetNewPreviewResponseModelFromJson(
    String str) =>
    GetLoanAssetNewPreviewResponseModel.fromJson(json.decode(str));

String getLoanAssetNewPreviewResponseModelToJson(
    GetLoanAssetNewPreviewResponseModel data) =>
    json.encode(data.toJson());

class GetLoanAssetNewPreviewResponseModel {
  int? status;
  String? message;
  dynamic data;
  List<AssetDataListPreview>? dataList;

  GetLoanAssetNewPreviewResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetLoanAssetNewPreviewResponseModel copyWith({
    int? status,
    String? message,
    dynamic data,
    List<AssetDataListPreview>? dataList,
  }) =>
      GetLoanAssetNewPreviewResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetLoanAssetNewPreviewResponseModel.fromJson(
      Map<String, dynamic> json) =>
      GetLoanAssetNewPreviewResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        dataList: List<AssetDataListPreview>.from(
            json["dataList"].map((x) => AssetDataListPreview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
  };
}

class AssetDataListPreview {
  int? id;
  int? loanMasterId;
  String? particulars;
  double ? presentMarketValue;
  int? assetDataId;
  int? assestTypeId;
  String? assetDataName;
  dynamic assestTypeName;

  AssetDataListPreview({
    this.id,
    this.loanMasterId,
    this.particulars,
    this.presentMarketValue,
    this.assetDataId,
    this.assestTypeId,
    this.assetDataName,
    this.assestTypeName,
  });

  AssetDataListPreview copyWith({
    int? id,
    int? loanMasterId,
    String? particulars,
    double? presentMarketValue,
    int? assetDataId,
    int? assestTypeId,
    String? assetDataName,
    dynamic assestTypeName,
  }) =>
      AssetDataListPreview(
        id: id ?? this.id,
        loanMasterId: loanMasterId ?? this.loanMasterId,
        particulars: particulars ?? this.particulars,
        presentMarketValue: presentMarketValue ?? this.presentMarketValue,
        assetDataId: assetDataId ?? this.assetDataId,
        assestTypeId: assestTypeId ?? this.assestTypeId,
        assetDataName: assetDataName ?? this.assetDataName,
        assestTypeName: assestTypeName ?? this.assestTypeName,
      );

  factory AssetDataListPreview.fromJson(Map<String, dynamic> json) => AssetDataListPreview(
    id: json["id"],
    loanMasterId: json["loanMasterId"],
    particulars: json["particulars"],
    presentMarketValue: json["presentMarketValue"],
    assetDataId: json["assetDataId"],
    assestTypeId: json["assestTypeId"],
    assetDataName: json["assetDataName"],
    assestTypeName: json["assestTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loanMasterId": loanMasterId,
    "particulars": particulars,
    "presentMarketValue": presentMarketValue,
    "assetDataId": assetDataId,
    "assestTypeId": assestTypeId,
    "assetDataName": assetDataName,
    "assestTypeName": assestTypeName,
  };
}
