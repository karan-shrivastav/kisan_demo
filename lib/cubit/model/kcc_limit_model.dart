// To parse this JSON data, do
//
//     final kccCubitModel = kccCubitModelFromJson(jsonString);

import 'dart:convert';

List<KccCubitModel> kccCubitModelFromJson(String str) =>
    List<KccCubitModel>.from(
        json.decode(str).map((x) => KccCubitModel.fromJson(x)));

String kccCubitModelToJson(List<KccCubitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KccCubitModel {
  String? productionLimit;
  String? familyConsumption;
  String? farmMaintenance;
  String? total;

  KccCubitModel({
    this.productionLimit,
    this.familyConsumption,
    this.farmMaintenance,
    this.total,
  });

  KccCubitModel copyWith({
    String? productionLimit,
    String? familyConsumption,
    String? farmMaintenance,
    String? total,
  }) =>
      KccCubitModel(
        productionLimit: productionLimit ?? this.productionLimit,
        familyConsumption: familyConsumption ?? this.familyConsumption,
        farmMaintenance: farmMaintenance ?? this.farmMaintenance,
        total: total ?? this.total,
      );

  factory KccCubitModel.fromJson(Map<String, dynamic> json) => KccCubitModel(
        productionLimit: json["productionLimit"],
        familyConsumption: json["familyConsumption"],
        farmMaintenance: json["farmMaintenance"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "productionLimit": productionLimit,
        "familyConsumption": familyConsumption,
        "farmMaintenance": farmMaintenance,
        "total": total,
      };
}
