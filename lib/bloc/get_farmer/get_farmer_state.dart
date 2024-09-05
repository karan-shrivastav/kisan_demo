
import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_farmer_by_id_response_model.dart';


abstract class GetFarmerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFarmerInitial extends GetFarmerState {}

class GetFarmerLoading extends GetFarmerState {}

class GetFarmerSuccess extends GetFarmerState {
  final GetFarmerByIdResponseModel getFarmerDetails;

  GetFarmerSuccess({required this.getFarmerDetails});

  @override
  List<Object?> get props => [getFarmerDetails];
}

class GetFarmerFail extends GetFarmerState {
  final CommonResponseModel commonResponseModel;
  GetFarmerFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
