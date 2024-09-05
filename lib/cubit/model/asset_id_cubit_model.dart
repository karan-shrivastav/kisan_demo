import 'dart:convert';

AssetCubitIdModel addLandCubitModelFromJson(String str) =>
    AssetCubitIdModel.fromJson(json.decode(str));

String addLandCubitModelToJson(AssetCubitIdModel data) =>
    json.encode(data.toJson());

class AssetCubitIdModel {
  int? movableId;
  int? immovableId;

  AssetCubitIdModel({
    this.movableId,
    this.immovableId,

  });

  AssetCubitIdModel copyWith({
    int? movableId,
    int? immovableId,
  }) =>
      AssetCubitIdModel(
        movableId: movableId ?? this.movableId,
        immovableId: immovableId ?? this.immovableId,
      );

  factory AssetCubitIdModel.fromJson(Map<String, dynamic> json) =>
      AssetCubitIdModel(
        movableId: json["movableId"],
        immovableId: json["immovableId"],
      );

  Map<String, dynamic> toJson() => {
    "movableId": movableId,
    "immovableId": immovableId,
  };
}
