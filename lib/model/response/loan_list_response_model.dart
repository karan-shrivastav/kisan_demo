import 'dart:convert';

GetLoanListResponseModel getLoanListResponseModelFromJson(String str) => GetLoanListResponseModel.fromJson(json.decode(str));

String getLoanListResponseModelToJson(GetLoanListResponseModel data) => json.encode(data.toJson());

class GetLoanListResponseModel {
  int? status;
  String? message;
  Data? data;
  dynamic dataList;

  GetLoanListResponseModel({
    this.status,
    this.message,
    this.data,
    this.dataList,
  });

  GetLoanListResponseModel copyWith({
    int? status,
    String? message,
    Data? data,
    dynamic dataList,
  }) =>
      GetLoanListResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        dataList: dataList ?? this.dataList,
      );

  factory GetLoanListResponseModel.fromJson(Map<String, dynamic> json) => GetLoanListResponseModel(
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
  List<Content>? content;
  int? numberOfPages;
  dynamic numOfLedDistributed;
  int? numberOfTotalElements;
  dynamic others;

  Data({
    this.content,
    this.numberOfPages,
    this.numOfLedDistributed,
    this.numberOfTotalElements,
    this.others,
  });

  Data copyWith({
    List<Content>? content,
    int? numberOfPages,
    dynamic numOfLedDistributed,
    int? numberOfTotalElements,
    dynamic others,
  }) =>
      Data(
        content: content ?? this.content,
        numberOfPages: numberOfPages ?? this.numberOfPages,
        numOfLedDistributed: numOfLedDistributed ?? this.numOfLedDistributed,
        numberOfTotalElements: numberOfTotalElements ?? this.numberOfTotalElements,
        others: others ?? this.others,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    numberOfPages: json["numberOfPages"],
    numOfLedDistributed: json["numOfLedDistributed"],
    numberOfTotalElements: json["numberOfTotalElements"],
    others: json["others"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content!.map((x) => x.toJson())),
    "numberOfPages": numberOfPages,
    "numOfLedDistributed": numOfLedDistributed,
    "numberOfTotalElements": numberOfTotalElements,
    "others": others,
  };
}

class Content {
  int? loanMasterId;
  String? applicationId;
  double? amount;
  String? status;
  DateTime? statusDate;
  String? type;
  String? name;
  int? userId;
  String? mode;
  dynamic pacsId;

  Content({
    this.loanMasterId,
    this.applicationId,
    this.amount,
    this.status,
    this.statusDate,
    this.type,
    this.name,
    this.userId,
    this.mode,
    this.pacsId,
  });

  Content copyWith({
    int? loanMasterId,
    String? applicationId,
    double? amount,
    String? status,
    DateTime? statusDate,
    String? type,
    String? name,
    int? userId,
    String? mode,
    dynamic pacsId,
  }) =>
      Content(
        loanMasterId: loanMasterId ?? this.loanMasterId,
        applicationId: applicationId ?? this.applicationId,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        statusDate: statusDate ?? this.statusDate,
        type: type ?? this.type,
        name: name ?? this.name,
        userId: userId ?? this.userId,
        mode: mode ?? this.mode,
        pacsId: pacsId ?? this.pacsId,
      );

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    loanMasterId: json["loanMasterId"],
    applicationId: json["applicationId"],
    amount: json["amount"],
    status: json["status"],
    statusDate: DateTime.parse(json["statusDate"]),
    type: json["type"],
    name: json["name"],
    userId: json["userId"],
    mode: json["mode"],
    pacsId: json["pacsId"],
  );

  Map<String, dynamic> toJson() => {
    "loanMasterId": loanMasterId,
    "applicationId": applicationId,
    "amount": amount,
    "status": status,
    "statusDate": statusDate?.toIso8601String(),
    "type": type,
    "name": name,
    "userId": userId,
    "mode": mode,
    "pacsId": pacsId,
  };
}











//
//
//
// // To parse this JSON data, do
// //
// //     final getLoanListResponseModel = getLoanListResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetLoanListResponseModel getLoanListResponseModelFromJson(String str) => GetLoanListResponseModel.fromJson(json.decode(str));
//
// String getLoanListResponseModelToJson(GetLoanListResponseModel data) => json.encode(data.toJson());
//
// class GetLoanListResponseModel {
//   int ?status;
//   String ?message;
//   LoanListData ?data;
//   dynamic dataList;
//
//   GetLoanListResponseModel({
//     this.status,
//     this.message,
//     this.data,
//     this.dataList,
//   });
//
//   GetLoanListResponseModel copyWith({
//     int? status,
//     String? message,
//     LoanListData? data,
//     dynamic dataList,
//   }) =>
//       GetLoanListResponseModel(
//         status: status ?? this.status,
//         message: message ?? this.message,
//         data: data ?? this.data,
//         dataList: dataList ?? this.dataList,
//       );
//
//   factory GetLoanListResponseModel.fromJson(Map<String, dynamic> json) => GetLoanListResponseModel(
//     status: json["status"],
//     message: json["message"],
//     data: LoanListData.fromJson(json["data"]),
//     dataList: json["dataList"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data?.toJson(),
//     "dataList": dataList,
//   };
// }
//
// class LoanListData {
//   List<Content>? content;
//   int ?numberOfPages;
//   dynamic numOfLedDistributed;
//   int ?numberOfTotalElements;
//   dynamic others;
//
//   LoanListData({
//     this.content,
//     this.numberOfPages,
//     this.numOfLedDistributed,
//     this.numberOfTotalElements,
//     this.others,
//   });
//
//   LoanListData copyWith({
//     List<Content>? content,
//     int? numberOfPages,
//     dynamic numOfLedDistributed,
//     int? numberOfTotalElements,
//     dynamic others,
//   }) =>
//       LoanListData(
//         content: content ?? this.content,
//         numberOfPages: numberOfPages ?? this.numberOfPages,
//         numOfLedDistributed: numOfLedDistributed ?? this.numOfLedDistributed,
//         numberOfTotalElements: numberOfTotalElements ?? this.numberOfTotalElements,
//         others: others ?? this.others,
//       );
//
//   factory LoanListData.fromJson(Map<String, dynamic> json) => LoanListData(
//     content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
//     numberOfPages: json["numberOfPages"],
//     numOfLedDistributed: json["numOfLedDistributed"],
//     numberOfTotalElements: json["numberOfTotalElements"],
//     others: json["others"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "content": List<dynamic>.from(content!.map((x) => x.toJson())),
//     "numberOfPages": numberOfPages,
//     "numOfLedDistributed": numOfLedDistributed,
//     "numberOfTotalElements": numberOfTotalElements,
//     "others": others,
//   };
// }
//
// class Content {
//   int ?loanMasterId;
//   String? applicationId;
//   int ?amount;
//   String? status;
//   DateTime? statusDate;
//   String ?type;
//   String ?name;
//   int? userId;
//   String ?mode;
//   dynamic pacsId;
//
//   Content({
//     this.loanMasterId,
//     this.applicationId,
//     this.amount,
//     this.status,
//     this.statusDate,
//     this.type,
//     this.name,
//     this.userId,
//     this.mode,
//     this.pacsId,
//   });
//
//   Content copyWith({
//     int? loanMasterId,
//     String? applicationId,
//     int? amount,
//     String? status,
//     DateTime? statusDate,
//     String? type,
//     String? name,
//     int? userId,
//     String? mode,
//     dynamic pacsId,
//   }) =>
//       Content(
//         loanMasterId: loanMasterId ?? this.loanMasterId,
//         applicationId: applicationId ?? this.applicationId,
//         amount: amount ?? this.amount,
//         status: status ?? this.status,
//         statusDate: statusDate ?? this.statusDate,
//         type: type ?? this.type,
//         name: name ?? this.name,
//         userId: userId ?? this.userId,
//         mode: mode ?? this.mode,
//         pacsId: pacsId ?? this.pacsId,
//       );
//
//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//     loanMasterId: json["loanMasterId"],
//     applicationId: json["applicationId"],
//     amount: json["amount"],
//     status: json["status"],
//     statusDate: DateTime.parse(json["statusDate"]),
//     type: json["type"],
//     name: json["name"],
//     userId: json["userId"],
//     mode: json["mode"],
//     pacsId: json["pacsId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "loanMasterId": loanMasterId,
//     "applicationId": applicationId,
//     "amount": amount,
//     "status": status,
//     "statusDate": statusDate!.toIso8601String(),
//     "type": type,
//     "name": name,
//     "userId": userId,
//     "mode": mode,
//     "pacsId": pacsId,
//   };
// }
