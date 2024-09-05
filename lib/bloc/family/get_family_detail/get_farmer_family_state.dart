import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:ekisan_credit/model/response/farmer_family_detail_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetFarmerFamilyDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFarmerFamilyDetailDetailInitial extends GetFarmerFamilyDetailState {
  final GetFarmerFamilyDetailResponseModel getFarmerFamilyDetailResponseModel;

  GetFarmerFamilyDetailDetailInitial(
      {required this.getFarmerFamilyDetailResponseModel});
}

class GetFarmerFamilyDetailDetailLoading extends GetFarmerFamilyDetailState {}

class GetFarmerFamilyDetailDetailSuccess extends GetFarmerFamilyDetailState {
  final GetFarmerFamilyDetailResponseModel getFarmerFamilyDetailResponseModel;

  GetFarmerFamilyDetailDetailSuccess(
      {required this.getFarmerFamilyDetailResponseModel});

  @override
  List<Object?> get props => [getFarmerFamilyDetailResponseModel];
}

class GetFarmerFamilyDetailDetailFail extends GetFarmerFamilyDetailState {
  final CommonResponseModel commonResponseModel;

  GetFarmerFamilyDetailDetailFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
