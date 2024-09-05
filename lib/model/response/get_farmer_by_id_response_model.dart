// // To parse this JSON data, do
// //
// //     final getFarmerByIdResponseModel = getFarmerByIdResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetFarmerByIdResponseModel getFarmerByIdResponseModelFromJson(String str) =>
//     GetFarmerByIdResponseModel.fromJson(json.decode(str));
//
// String getFarmerByIdResponseModelToJson(GetFarmerByIdResponseModel data) =>
//     json.encode(data.toJson());
//
// class GetFarmerByIdResponseModel {
//   int? status;
//   String? message;
//   FarmerDataResponse? data;
//   dynamic dataList;
//
//   GetFarmerByIdResponseModel({
//     this.status,
//     this.message,
//     this.data,
//     this.dataList,
//   });
//
//   GetFarmerByIdResponseModel copyWith({
//     int? status,
//     String? message,
//     FarmerDataResponse? data,
//     dynamic dataList,
//   }) =>
//       GetFarmerByIdResponseModel(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         data: data ?? this.data,
//         dataList: dataList ?? this.dataList,
//       );
//
//   factory GetFarmerByIdResponseModel.fromJson(Map<String, dynamic> json) =>
//       GetFarmerByIdResponseModel(
//         status: json["status"],
//         message: json["message"],
//         data: FarmerDataResponse.fromJson(json["data"]),
//         dataList: json["dataList"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data!.toJson(),
//         "dataList": dataList,
//       };
// }
//
// class FarmerDataResponse {
//   int? farmerId;
//   String? fullName;
//   Cast? title;
//   String? titleName;
//   Cast? cast;
//   String? castName;
//   Cast? religion;
//   String? religionName;
//   dynamic sonOrWifeOf;
//   Cast? occupation;
//   String? occupationName;
//   DateTime? dateOfBirth;
//   Cast? gender;
//   String? genderName;
//   Cast? proofOfIdentity;
//   String? proofOfIdentityName;
//   String? idProofNumber;
//   String? physicallyChallenged;
//   List<AddressDto>? addressDtos;
//   String? relativeName;
//   int? mobileNo;
//   dynamic email;
//   bool? bothAddressSame;
//   AadharAddressMapper? aadharAddressMapper;
//   String? aadharAddress;
//   String? pht;
//
//   FarmerDataResponse({
//     this.farmerId,
//     this.fullName,
//     this.title,
//     this.titleName,
//     this.cast,
//     this.castName,
//     this.religion,
//     this.religionName,
//     this.sonOrWifeOf,
//     this.occupation,
//     this.occupationName,
//     this.dateOfBirth,
//     this.gender,
//     this.genderName,
//     this.proofOfIdentity,
//     this.proofOfIdentityName,
//     this.idProofNumber,
//     this.physicallyChallenged,
//     this.addressDtos,
//     this.relativeName,
//     this.mobileNo,
//     this.email,
//     this.bothAddressSame,
//     this.aadharAddressMapper,
//     this.aadharAddress,
//     this.pht,
//   });
//
//   FarmerDataResponse copyWith({
//     int? farmerId,
//     String? fullName,
//     Cast? title,
//     String? titleName,
//     Cast? cast,
//     String? castName,
//     Cast? religion,
//     String? religionName,
//     dynamic sonOrWifeOf,
//     Cast? occupation,
//     String? occupationName,
//     DateTime? dateOfBirth,
//     Cast? gender,
//     String? genderName,
//     Cast? proofOfIdentity,
//     String? proofOfIdentityName,
//     String? idProofNumber,
//     String? physicallyChallenged,
//     List<AddressDto>? addressDtos,
//     String? relativeName,
//     int? mobileNo,
//     dynamic email,
//     bool? bothAddressSame,
//     AadharAddressMapper? aadharAddressMapper,
//     String? aadharAddress,
//     String? pht,
//   }) =>
//       FarmerDataResponse(
//         farmerId: farmerId ?? this.farmerId,
//         fullName: fullName ?? this.fullName,
//         title: title ?? this.title,
//         titleName: titleName ?? this.titleName,
//         cast: cast ?? this.cast,
//         castName: castName ?? this.castName,
//         religion: religion ?? this.religion,
//         religionName: religionName ?? this.religionName,
//         sonOrWifeOf: sonOrWifeOf ?? this.sonOrWifeOf,
//         occupation: occupation ?? this.occupation,
//         occupationName: occupationName ?? this.occupationName,
//         dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//         gender: gender ?? this.gender,
//         genderName: genderName ?? this.genderName,
//         proofOfIdentity: proofOfIdentity ?? this.proofOfIdentity,
//         proofOfIdentityName: proofOfIdentityName ?? this.proofOfIdentityName,
//         idProofNumber: idProofNumber ?? this.idProofNumber,
//         physicallyChallenged: physicallyChallenged ?? this.physicallyChallenged,
//         addressDtos: addressDtos ?? this.addressDtos,
//         relativeName: relativeName ?? this.relativeName,
//         mobileNo: mobileNo ?? this.mobileNo,
//         email: email ?? this.email,
//         bothAddressSame: bothAddressSame ?? this.bothAddressSame,
//         aadharAddressMapper: aadharAddressMapper ?? this.aadharAddressMapper,
//         aadharAddress: aadharAddress ?? this.aadharAddress,
//         pht: pht ?? this.pht,
//       );
//
//   factory FarmerDataResponse.fromJson(Map<String, dynamic> json) =>
//       FarmerDataResponse(
//         farmerId: json["farmerId"],
//         fullName: json["fullName"],
//         title: Cast.fromJson(json["title"]),
//         titleName: json["titleName"],
//         cast: Cast.fromJson(json["cast"]),
//         castName: json["castName"],
//         religion: Cast.fromJson(json["religion"]),
//         religionName: json["religionName"],
//         sonOrWifeOf: json["sonOrWifeOf"],
//         occupation: Cast.fromJson(json["occupation"]),
//         occupationName: json["occupationName"],
//         dateOfBirth: DateTime.parse(json["dateOfBirth"]),
//         gender: Cast.fromJson(json["gender"]),
//         genderName: json["genderName"],
//         proofOfIdentity: Cast.fromJson(json["proofOfIdentity"]),
//         proofOfIdentityName: json["proofOfIdentityName"],
//         idProofNumber: json["idProofNumber"],
//         physicallyChallenged: json["physicallyChallenged"],
//         addressDtos: List<AddressDto>.from(
//             json["addressDtos"].map((x) => AddressDto.fromJson(x))),
//         relativeName: json["relativeName"],
//         mobileNo: json["mobileNo"],
//         email: json["email"],
//         bothAddressSame: json["bothAddressSame"],
//         aadharAddressMapper:
//             AadharAddressMapper.fromJson(json["aadharAddressMapper"]),
//         aadharAddress: json["aadharAddress"],
//         pht: json["pht"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "farmerId": farmerId,
//         "fullName": fullName,
//         "title": title?.toJson(),
//         "titleName": titleName,
//         "cast": cast?.toJson(),
//         "castName": castName,
//         "religion": religion?.toJson(),
//         "religionName": religionName,
//         "sonOrWifeOf": sonOrWifeOf,
//         "occupation": occupation?.toJson(),
//         "occupationName": occupationName,
//         "dateOfBirth":
//             "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
//         "gender": gender?.toJson(),
//         "genderName": genderName,
//         "proofOfIdentity": proofOfIdentity?.toJson(),
//         "proofOfIdentityName": proofOfIdentityName,
//         "idProofNumber": idProofNumber,
//         "physicallyChallenged": physicallyChallenged,
//         "addressDtos": List<dynamic>.from(addressDtos!.map((x) => x.toJson())),
//         "relativeName": relativeName,
//         "mobileNo": mobileNo,
//         "email": email,
//         "bothAddressSame": bothAddressSame,
//         "aadharAddressMapper": aadharAddressMapper?.toJson(),
//         "aadharAddress": aadharAddress,
//         "pht": pht,
//       };
// }
//
// class AadharAddressMapper {
//   String? country;
//   String? subdist;
//   String? pc;
//   String? vtc;
//   dynamic street;
//   String? dist;
//   String? state;
//   String? co;
//   String? house;
//   String? po;
//   dynamic lm;
//   String? loc;
//   dynamic lang;
//
//   AadharAddressMapper({
//     this.country,
//     this.subdist,
//     this.pc,
//     this.vtc,
//     this.street,
//     this.dist,
//     this.state,
//     this.co,
//     this.house,
//     this.po,
//     this.lm,
//     this.loc,
//     this.lang,
//   });
//
//   AadharAddressMapper copyWith({
//     String? country,
//     String? subdist,
//     String? pc,
//     String? vtc,
//     dynamic street,
//     String? dist,
//     String? state,
//     String? co,
//     String? house,
//     String? po,
//     dynamic lm,
//     String? loc,
//     dynamic lang,
//   }) =>
//       AadharAddressMapper(
//         country: country ?? this.country,
//         subdist: subdist ?? this.subdist,
//         pc: pc ?? this.pc,
//         vtc: vtc ?? this.vtc,
//         street: street ?? this.street,
//         dist: dist ?? this.dist,
//         state: state ?? this.state,
//         co: co ?? this.co,
//         house: house ?? this.house,
//         po: po ?? this.po,
//         lm: lm ?? this.lm,
//         loc: loc ?? this.loc,
//         lang: lang ?? this.lang,
//       );
//
//   factory AadharAddressMapper.fromJson(Map<String, dynamic> json) =>
//       AadharAddressMapper(
//         country: json["country"],
//         subdist: json["subdist"],
//         pc: json["pc"],
//         vtc: json["vtc"],
//         street: json["street"],
//         dist: json["dist"],
//         state: json["state"],
//         co: json["co"],
//         house: json["house"],
//         po: json["po"],
//         lm: json["lm"],
//         loc: json["loc"],
//         lang: json["lang"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "country": country,
//         "subdist": subdist,
//         "pc": pc,
//         "vtc": vtc,
//         "street": street,
//         "dist": dist,
//         "state": state,
//         "co": co,
//         "house": house,
//         "po": po,
//         "lm": lm,
//         "loc": loc,
//         "lang": lang,
//       };
// }
//
// class AddressDto {
//   int? id;
//   int? stateId;
//   String? stateName;
//   int? districtId;
//   String? districtName;
//   String? villageName;
//   String? address;
//   String? pincode;
//   String? addressType;
//   int? villageId;
//   String? villageLocalName;
//
//   AddressDto({
//     this.id,
//     this.stateId,
//     this.stateName,
//     this.districtId,
//     this.districtName,
//     this.villageName,
//     this.address,
//     this.pincode,
//     this.addressType,
//     this.villageId,
//     this.villageLocalName,
//   });
//
//   AddressDto copyWith({
//     int? id,
//     int? stateId,
//     String? stateName,
//     int? districtId,
//     String? districtName,
//     String? villageName,
//     String? address,
//     String? pincode,
//     String? addressType,
//     int? villageId,
//     String? villageLocalName,
//   }) =>
//       AddressDto(
//         id: id ?? this.id,
//         stateId: stateId ?? this.stateId,
//         stateName: stateName ?? this.stateName,
//         districtId: districtId ?? this.districtId,
//         districtName: districtName ?? this.districtName,
//         villageName: villageName ?? this.villageName,
//         address: address ?? this.address,
//         pincode: pincode ?? this.pincode,
//         addressType: addressType ?? this.addressType,
//         villageId: villageId ?? this.villageId,
//         villageLocalName: villageLocalName ?? this.villageLocalName,
//       );
//
//   factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
//         id: json["id"],
//         stateId: json["stateId"],
//         stateName: json["stateName"],
//         districtId: json["districtId"],
//         districtName: json["districtName"],
//         villageName: json["villageName"],
//         address: json["address"],
//         pincode: json["pincode"],
//         addressType: json["addressType"],
//         villageId: json["villageId"],
//         villageLocalName: json["villageLocalName"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "stateId": stateId,
//         "stateName": stateName,
//         "districtId": districtId,
//         "districtName": districtName,
//         "villageName": villageName,
//         "address": address,
//         "pincode": pincode,
//         "addressType": addressType,
//         "villageId": villageId,
//         "villageLocalName": villageLocalName,
//       };
// }
//
// class Cast {
//   dynamic createdBy;
//   dynamic createdDate;
//   dynamic lastModifiedBy;
//   dynamic lastModifiedDate;
//   int? id;
//   String? parLovType;
//   String? lovType;
//   String? value;
//   int? priority;
//   int? isDeleted;
//   dynamic comment;
//   String? valueHindi;
//   String? valueEnglish;
//   String? valueGujrati;
//   String? valueBengali;
//   String? valuePanjabi;
//   dynamic valueSanskrit;
//   dynamic valueAssamese;
//   String? valueKannada;
//   dynamic valueKashmiri;
//   dynamic valueKonkani;
//   String? valueMalayalam;
//   String? valueMarathi;
//   String? valueNepali;
//   String? valueOdia;
//   String? valueTamil;
//   String? valueTelugu;
//   String? valueUrdu;
//   int? valueCode;
//
//   Cast({
//     this.createdBy,
//     this.createdDate,
//     this.lastModifiedBy,
//     this.lastModifiedDate,
//     this.id,
//     this.parLovType,
//     this.lovType,
//     this.value,
//     this.priority,
//     this.isDeleted,
//     this.comment,
//     this.valueHindi,
//     this.valueEnglish,
//     this.valueGujrati,
//     this.valueBengali,
//     this.valuePanjabi,
//     this.valueSanskrit,
//     this.valueAssamese,
//     this.valueKannada,
//     this.valueKashmiri,
//     this.valueKonkani,
//     this.valueMalayalam,
//     this.valueMarathi,
//     this.valueNepali,
//     this.valueOdia,
//     this.valueTamil,
//     this.valueTelugu,
//     this.valueUrdu,
//     this.valueCode,
//   });
//
//   Cast copyWith({
//     dynamic createdBy,
//     dynamic createdDate,
//     dynamic lastModifiedBy,
//     dynamic lastModifiedDate,
//     int? id,
//     String? parLovType,
//     String? lovType,
//     String? value,
//     int? priority,
//     int? isDeleted,
//     dynamic comment,
//     String? valueHindi,
//     String? valueEnglish,
//     String? valueGujrati,
//     String? valueBengali,
//     String? valuePanjabi,
//     dynamic valueSanskrit,
//     dynamic valueAssamese,
//     String? valueKannada,
//     dynamic valueKashmiri,
//     dynamic valueKonkani,
//     String? valueMalayalam,
//     String? valueMarathi,
//     String? valueNepali,
//     String? valueOdia,
//     String? valueTamil,
//     String? valueTelugu,
//     String? valueUrdu,
//     int? valueCode,
//   }) =>
//       Cast(
//         createdBy: createdBy ?? this.createdBy,
//         createdDate: createdDate ?? this.createdDate,
//         lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
//         lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
//         id: id ?? this.id,
//         parLovType: parLovType ?? this.parLovType,
//         lovType: lovType ?? this.lovType,
//         value: value ?? this.value,
//         priority: priority ?? this.priority,
//         isDeleted: isDeleted ?? this.isDeleted,
//         comment: comment ?? this.comment,
//         valueHindi: valueHindi ?? this.valueHindi,
//         valueEnglish: valueEnglish ?? this.valueEnglish,
//         valueGujrati: valueGujrati ?? this.valueGujrati,
//         valueBengali: valueBengali ?? this.valueBengali,
//         valuePanjabi: valuePanjabi ?? this.valuePanjabi,
//         valueSanskrit: valueSanskrit ?? this.valueSanskrit,
//         valueAssamese: valueAssamese ?? this.valueAssamese,
//         valueKannada: valueKannada ?? this.valueKannada,
//         valueKashmiri: valueKashmiri ?? this.valueKashmiri,
//         valueKonkani: valueKonkani ?? this.valueKonkani,
//         valueMalayalam: valueMalayalam ?? this.valueMalayalam,
//         valueMarathi: valueMarathi ?? this.valueMarathi,
//         valueNepali: valueNepali ?? this.valueNepali,
//         valueOdia: valueOdia ?? this.valueOdia,
//         valueTamil: valueTamil ?? this.valueTamil,
//         valueTelugu: valueTelugu ?? this.valueTelugu,
//         valueUrdu: valueUrdu ?? this.valueUrdu,
//         valueCode: valueCode ?? this.valueCode,
//       );
//
//   factory Cast.fromJson(Map<String, dynamic> json) => Cast(
//         createdBy: json["createdBy"],
//         createdDate: json["createdDate"],
//         lastModifiedBy: json["lastModifiedBy"],
//         lastModifiedDate: json["lastModifiedDate"],
//         id: json["id"],
//         parLovType: json["parLovType"],
//         lovType: json["lovType"],
//         value: json["value"],
//         priority: json["priority"],
//         isDeleted: json["isDeleted"],
//         comment: json["comment"],
//         valueHindi: json["valueHindi"],
//         valueEnglish: json["valueEnglish"],
//         valueGujrati: json["valueGujrati"],
//         valueBengali: json["valueBengali"],
//         valuePanjabi: json["valuePanjabi"],
//         valueSanskrit: json["valueSanskrit"],
//         valueAssamese: json["valueAssamese"],
//         valueKannada: json["valueKannada"],
//         valueKashmiri: json["valueKashmiri"],
//         valueKonkani: json["valueKonkani"],
//         valueMalayalam: json["valueMalayalam"],
//         valueMarathi: json["valueMarathi"],
//         valueNepali: json["valueNepali"],
//         valueOdia: json["valueOdia"],
//         valueTamil: json["valueTamil"],
//         valueTelugu: json["valueTelugu"],
//         valueUrdu: json["valueUrdu"],
//         valueCode: json["valueCode"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "createdBy": createdBy,
//         "createdDate": createdDate,
//         "lastModifiedBy": lastModifiedBy,
//         "lastModifiedDate": lastModifiedDate,
//         "id": id,
//         "parLovType": parLovType,
//         "lovType": lovType,
//         "value": value,
//         "priority": priority,
//         "isDeleted": isDeleted,
//         "comment": comment,
//         "valueHindi": valueHindi,
//         "valueEnglish": valueEnglish,
//         "valueGujrati": valueGujrati,
//         "valueBengali": valueBengali,
//         "valuePanjabi": valuePanjabi,
//         "valueSanskrit": valueSanskrit,
//         "valueAssamese": valueAssamese,
//         "valueKannada": valueKannada,
//         "valueKashmiri": valueKashmiri,
//         "valueKonkani": valueKonkani,
//         "valueMalayalam": valueMalayalam,
//         "valueMarathi": valueMarathi,
//         "valueNepali": valueNepali,
//         "valueOdia": valueOdia,
//         "valueTamil": valueTamil,
//         "valueTelugu": valueTelugu,
//         "valueUrdu": valueUrdu,
//         "valueCode": valueCode,
//       };
// }


import 'dart:convert';

GetFarmerByIdResponseModel getFarmerByIdResponseModelFromJson(String str) => GetFarmerByIdResponseModel.fromJson(json.decode(str));

String getFarmerByIdResponseModelToJson(GetFarmerByIdResponseModel data) => json.encode(data.toJson());

class GetFarmerByIdResponseModel {
  int? status;
  String? message;
  FarmerDataResponse? data;
  dynamic dataList;

  GetFarmerByIdResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetFarmerByIdResponseModel copyWith({
    int? status,
    String? message,
    FarmerDataResponse? data,
    dynamic dataList,
  }) =>
      GetFarmerByIdResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetFarmerByIdResponseModel.fromJson(Map<String, dynamic> json) => GetFarmerByIdResponseModel(
    status: json["status"],
    message: json["message"],
    data: FarmerDataResponse.fromJson(json["data"]),
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "dataList": dataList,
  };
}

class FarmerDataResponse {
  int? farmerId;
  String? fullName;
  Cast? title;
  String? titleName;
  Cast? cast;
  String? castName;
  Cast? religion;
  String? religionName;
  String? sonOrWifeOf;
  Cast? occupation;
  String? occupationName;
  DateTime? dateOfBirth;
  Cast? gender;
  String? genderName;
  Cast? proofOfIdentity;
  String? proofOfIdentityName;
  String? idProofNumber;
  String? physicallyChallenged;
  List<AddressDto>? addressDtos;
  String? relativeName;
  int? mobileNo;
  String? email;
  bool? bothAddressSame;

  FarmerDataResponse({
    this.farmerId,
    this.fullName,
    this.title,
    this.titleName,
    this.cast,
    this.castName,
    this.religion,
    this.religionName,
    this.sonOrWifeOf,
    this.occupation,
    this.occupationName,
    this.dateOfBirth,
    this.gender,
    this.genderName,
    this.proofOfIdentity,
    this.proofOfIdentityName,
    this.idProofNumber,
    this.physicallyChallenged,
    this.addressDtos,
    this.relativeName,
    this.mobileNo,
    this.email,
    this.bothAddressSame,
  });

  FarmerDataResponse copyWith({
    int? farmerId,
    String? fullName,
    Cast? title,
    String? titleName,
    Cast? cast,
    String? castName,
    Cast? religion,
    String? religionName,
    String? sonOrWifeOf,
    Cast? occupation,
    String? occupationName,
    DateTime? dateOfBirth,
    Cast? gender,
    String? genderName,
    Cast? proofOfIdentity,
    String? proofOfIdentityName,
    String? idProofNumber,
    String? physicallyChallenged,
    List<AddressDto>? addressDtos,
    String? relativeName,
    int? mobileNo,
    String? email,
    bool? bothAddressSame,
  }) =>
      FarmerDataResponse(
        farmerId: farmerId ?? this.farmerId,
        fullName: fullName ?? this.fullName,
        title: title ?? this.title,
        titleName: titleName ?? this.titleName,
        cast: cast ?? this.cast,
        castName: castName ?? this.castName,
        religion: religion ?? this.religion,
        religionName: religionName ?? this.religionName,
        sonOrWifeOf: sonOrWifeOf ?? this.sonOrWifeOf,
        occupation: occupation ?? this.occupation,
        occupationName: occupationName ?? this.occupationName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        genderName: genderName ?? this.genderName,
        proofOfIdentity: proofOfIdentity ?? this.proofOfIdentity,
        proofOfIdentityName: proofOfIdentityName ?? this.proofOfIdentityName,
        idProofNumber: idProofNumber ?? this.idProofNumber,
        physicallyChallenged: physicallyChallenged ?? this.physicallyChallenged,
        addressDtos: addressDtos ?? this.addressDtos,
        relativeName: relativeName ?? this.relativeName,
        mobileNo: mobileNo ?? this.mobileNo,
        email: email ?? this.email,
        bothAddressSame: bothAddressSame ?? this.bothAddressSame,
      );

  factory FarmerDataResponse.fromJson(Map<String, dynamic> json) => FarmerDataResponse(
    farmerId: json["farmerId"],
    fullName: json["fullName"],
    title: Cast.fromJson(json["title"]),
    titleName: json["titleName"],
    cast: Cast.fromJson(json["cast"]),
    castName: json["castName"],
    religion: Cast.fromJson(json["religion"]),
    religionName: json["religionName"],
    sonOrWifeOf: json["sonOrWifeOf"],
    occupation: Cast.fromJson(json["occupation"]),
    occupationName: json["occupationName"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    gender: Cast.fromJson(json["gender"]),
    genderName: json["genderName"],
    proofOfIdentity: Cast.fromJson(json["proofOfIdentity"]),
    proofOfIdentityName: json["proofOfIdentityName"],
    idProofNumber: json["idProofNumber"],
    physicallyChallenged: json["physicallyChallenged"],
    addressDtos: List<AddressDto>.from(json["addressDtos"].map((x) => AddressDto.fromJson(x))),
    relativeName: json["relativeName"],
    mobileNo: json["mobileNo"],
    email: json["email"],
    bothAddressSame: json["bothAddressSame"],
  );

  Map<String, dynamic> toJson() => {
    "farmerId": farmerId,
    "fullName": fullName,
    "title": title?.toJson(),
    "titleName": titleName,
    "cast": cast?.toJson(),
    "castName": castName,
    "religion": religion?.toJson(),
    "religionName": religionName,
    "sonOrWifeOf": sonOrWifeOf,
    "occupation": occupation?.toJson(),
    "occupationName": occupationName,
    "dateOfBirth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
    "gender": gender?.toJson(),
    "genderName": genderName,
    "proofOfIdentity": proofOfIdentity?.toJson(),
    "proofOfIdentityName": proofOfIdentityName,
    "idProofNumber": idProofNumber,
    "physicallyChallenged": physicallyChallenged,
    "addressDtos": List<dynamic>.from(addressDtos!.map((x) => x.toJson())),
    "relativeName": relativeName,
    "mobileNo": mobileNo,
    "email": email,
    "bothAddressSame": bothAddressSame,
  };
}

class AddressDto {
  int? id;
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;
  String? villageName;
  String? address;
  String? pincode;
  String? addressType;
  int? villageId;
  dynamic villageLocalName;

  AddressDto({
    this.id,
    this.stateId,
    this.stateName,
    this.districtId,
    this.districtName,
    this.villageName,
    this.address,
    this.pincode,
    this.addressType,
    this.villageId,
    this.villageLocalName,
  });

  AddressDto copyWith({
    int? id,
    int? stateId,
    String? stateName,
    int? districtId,
    String? districtName,
    String? villageName,
    String? address,
    String? pincode,
    String? addressType,
    int? villageId,
    dynamic villageLocalName,
  }) =>
      AddressDto(
        id: id ?? this.id,
        stateId: stateId ?? this.stateId,
        stateName: stateName ?? this.stateName,
        districtId: districtId ?? this.districtId,
        districtName: districtName ?? this.districtName,
        villageName: villageName ?? this.villageName,
        address: address ?? this.address,
        pincode: pincode ?? this.pincode,
        addressType: addressType ?? this.addressType,
        villageId: villageId ?? this.villageId,
        villageLocalName: villageLocalName ?? this.villageLocalName,
      );

  factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
    id: json["id"],
    stateId: json["stateId"],
    stateName: json["stateName"],
    districtId: json["districtId"],
    districtName: json["districtName"],
    villageName: json["villageName"],
    address: json["address"],
    pincode: json["pincode"],
    addressType: json["addressType"],
    villageId: json["villageId"],
    villageLocalName: json["villageLocalName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateId": stateId,
    "stateName": stateName,
    "districtId": districtId,
    "districtName": districtName,
    "villageName": villageName,
    "address": address,
    "pincode": pincode,
    "addressType": addressType,
    "villageId": villageId,
    "villageLocalName": villageLocalName,
  };
}

class Cast {
  dynamic createdBy;
  dynamic createdDate;
  dynamic lastModifiedBy;
  dynamic lastModifiedDate;
  int? id;
  String? parLovType;
  String? lovType;
  String? value;
  int? priority;
  int? isDeleted;
  dynamic comment;
  String? valueHindi;
  String? valueEnglish;
  String? valueGujrati;
  String? valueBengali;
  String? valuePanjabi;
  dynamic valueSanskrit;
  dynamic valueAssamese;
  String? valueKannada;
  dynamic valueKashmiri;
  dynamic valueKonkani;
  String? valueMalayalam;
  String? valueMarathi;
  String? valueNepali;
  String? valueOdia;
  String? valueTamil;
  String? valueTelugu;
  String? valueUrdu;
  int? valueCode;

  Cast({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.parLovType,
    this.lovType,
    this.value,
    this.priority,
    this.isDeleted,
    this.comment,
    this.valueHindi,
    this.valueEnglish,
    this.valueGujrati,
    this.valueBengali,
    this.valuePanjabi,
    this.valueSanskrit,
    this.valueAssamese,
    this.valueKannada,
    this.valueKashmiri,
    this.valueKonkani,
    this.valueMalayalam,
    this.valueMarathi,
    this.valueNepali,
    this.valueOdia,
    this.valueTamil,
    this.valueTelugu,
    this.valueUrdu,
    this.valueCode,
  });

  Cast copyWith({
    dynamic createdBy,
    dynamic createdDate,
    dynamic lastModifiedBy,
    dynamic lastModifiedDate,
    int? id,
    String? parLovType,
    String? lovType,
    String? value,
    int? priority,
    int? isDeleted,
    dynamic comment,
    String? valueHindi,
    String? valueEnglish,
    String? valueGujrati,
    String? valueBengali,
    String? valuePanjabi,
    dynamic valueSanskrit,
    dynamic valueAssamese,
    String? valueKannada,
    dynamic valueKashmiri,
    dynamic valueKonkani,
    String? valueMalayalam,
    String? valueMarathi,
    String? valueNepali,
    String? valueOdia,
    String? valueTamil,
    String? valueTelugu,
    String? valueUrdu,
    int? valueCode,
  }) =>
      Cast(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        parLovType: parLovType ?? this.parLovType,
        lovType: lovType ?? this.lovType,
        value: value ?? this.value,
        priority: priority ?? this.priority,
        isDeleted: isDeleted ?? this.isDeleted,
        comment: comment ?? this.comment,
        valueHindi: valueHindi ?? this.valueHindi,
        valueEnglish: valueEnglish ?? this.valueEnglish,
        valueGujrati: valueGujrati ?? this.valueGujrati,
        valueBengali: valueBengali ?? this.valueBengali,
        valuePanjabi: valuePanjabi ?? this.valuePanjabi,
        valueSanskrit: valueSanskrit ?? this.valueSanskrit,
        valueAssamese: valueAssamese ?? this.valueAssamese,
        valueKannada: valueKannada ?? this.valueKannada,
        valueKashmiri: valueKashmiri ?? this.valueKashmiri,
        valueKonkani: valueKonkani ?? this.valueKonkani,
        valueMalayalam: valueMalayalam ?? this.valueMalayalam,
        valueMarathi: valueMarathi ?? this.valueMarathi,
        valueNepali: valueNepali ?? this.valueNepali,
        valueOdia: valueOdia ?? this.valueOdia,
        valueTamil: valueTamil ?? this.valueTamil,
        valueTelugu: valueTelugu ?? this.valueTelugu,
        valueUrdu: valueUrdu ?? this.valueUrdu,
        valueCode: valueCode ?? this.valueCode,
      );

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedDate: json["lastModifiedDate"],
    id: json["id"],
    parLovType: json["parLovType"],
    lovType: json["lovType"],
    value: json["value"],
    priority: json["priority"],
    isDeleted: json["isDeleted"],
    comment: json["comment"],
    valueHindi: json["valueHindi"],
    valueEnglish: json["valueEnglish"],
    valueGujrati: json["valueGujrati"],
    valueBengali: json["valueBengali"],
    valuePanjabi: json["valuePanjabi"],
    valueSanskrit: json["valueSanskrit"],
    valueAssamese: json["valueAssamese"],
    valueKannada: json["valueKannada"],
    valueKashmiri: json["valueKashmiri"],
    valueKonkani: json["valueKonkani"],
    valueMalayalam: json["valueMalayalam"],
    valueMarathi: json["valueMarathi"],
    valueNepali: json["valueNepali"],
    valueOdia: json["valueOdia"],
    valueTamil: json["valueTamil"],
    valueTelugu: json["valueTelugu"],
    valueUrdu: json["valueUrdu"],
    valueCode: json["valueCode"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate,
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedDate": lastModifiedDate,
    "id": id,
    "parLovType": parLovType,
    "lovType": lovType,
    "value": value,
    "priority": priority,
    "isDeleted": isDeleted,
    "comment": comment,
    "valueHindi": valueHindi,
    "valueEnglish": valueEnglish,
    "valueGujrati": valueGujrati,
    "valueBengali": valueBengali,
    "valuePanjabi": valuePanjabi,
    "valueSanskrit": valueSanskrit,
    "valueAssamese": valueAssamese,
    "valueKannada": valueKannada,
    "valueKashmiri": valueKashmiri,
    "valueKonkani": valueKonkani,
    "valueMalayalam": valueMalayalam,
    "valueMarathi": valueMarathi,
    "valueNepali": valueNepali,
    "valueOdia": valueOdia,
    "valueTamil": valueTamil,
    "valueTelugu": valueTelugu,
    "valueUrdu": valueUrdu,
    "valueCode": valueCode,
  };
}
