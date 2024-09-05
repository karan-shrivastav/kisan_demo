// To parse this JSON data, do
//
//     final createFarmerCurrentAddressCubitModel = createFarmerCurrentAddressCubitModelFromJson(jsonString);

import 'dart:convert';

CreateFarmerCurrentAddressCubitModel
    createFarmerCurrentAddressCubitModelFromJson(String str) =>
        CreateFarmerCurrentAddressCubitModel.fromJson(json.decode(str));

String createFarmerCurrentAddressCubitModelToJson(
        CreateFarmerCurrentAddressCubitModel data) =>
    json.encode(data.toJson());

class CreateFarmerCurrentAddressCubitModel {
  int? stateMasterId;
  String? selectedStateString;
  int? districtMasterId;
  String? selectedDistrictString;
  int? villageMasterId;
  String? selectedVillageString;
  String? address;
  String? enteredAddressString;
  String? pincode;
  String? addressType;
  bool? isAddressSame;

  CreateFarmerCurrentAddressCubitModel({
    this.stateMasterId,
    this.selectedStateString,
    this.districtMasterId,
    this.selectedDistrictString,
    this.villageMasterId,
    this.selectedVillageString,
    this.address,
    this.enteredAddressString,
    this.pincode,
    this.addressType,
    this.isAddressSame = false,
  });

  CreateFarmerCurrentAddressCubitModel copyWith(
          {int? stateMasterId,
          String? selectedStateString,
          int? districtMasterId,
          String? selectedDistrictString,
          int? villageMasterId,
          String? selectedVillageString,
          String? address,
          String? enteredAddressString,
          String? pincode,
          String? addressType,
          bool? isAddressSame}) =>
      CreateFarmerCurrentAddressCubitModel(
          stateMasterId: stateMasterId ?? this.stateMasterId,
          selectedStateString: selectedStateString ?? this.selectedStateString,
          districtMasterId: districtMasterId ?? this.districtMasterId,
          selectedDistrictString:
              selectedDistrictString ?? selectedDistrictString,
          villageMasterId: villageMasterId ?? this.villageMasterId,
          selectedVillageString:
              selectedVillageString ?? this.selectedVillageString,
          address: address ?? this.address,
          enteredAddressString:
              enteredAddressString ?? this.enteredAddressString,
          pincode: pincode ?? this.pincode,
          addressType: addressType ?? this.addressType,
          isAddressSame: isAddressSame ?? this.isAddressSame);

  factory CreateFarmerCurrentAddressCubitModel.fromJson(
          Map<String, dynamic> json) =>
      CreateFarmerCurrentAddressCubitModel(
          stateMasterId: json["stateMasterId"],
          selectedStateString: json["selectedStateString"],
          districtMasterId: json["districtMasterId"],
          selectedDistrictString: json["selecteddistrictString"],
          villageMasterId: json["villageMasterId"],
          selectedVillageString: json["selectedVillageString"],
          address: json["address"],
          enteredAddressString: json["enteredAddressString"],
          pincode: json["pincode"],
          addressType: json["addressType"],
          isAddressSame: json["isAddressSame"]);

  Map<String, dynamic> toJson() => {
        "stateMasterId": stateMasterId,
        "selectedStateString": selectedStateString,
        "districtMasterId": districtMasterId,
        "selectedDistrictString": selectedDistrictString,
        "villageMasterId": villageMasterId,
        "selectedVillageString": selectedVillageString,
        "address": address,
        "enteredAddressString": enteredAddressString,
        "pincode": pincode,
        "addressType": addressType,
        "isAddressSame": isAddressSame
      };
}
