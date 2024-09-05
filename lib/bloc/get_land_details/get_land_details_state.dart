
import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/land_details_response_model.dart';

abstract class GetLandDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLandDataInitial extends GetLandDataState {}

class GetLandDataLoading extends GetLandDataState {}

class GetLandDataSuccess extends GetLandDataState {
  final GetLandDetailsResponseModel getLandResponseModel;
  GetLandDataSuccess({required this.getLandResponseModel});
  @override
  List<Object?> get props => [getLandResponseModel];
}

class GetLandDataFail extends GetLandDataState {
  final CommonResponseModel commonResponseModel;
  GetLandDataFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
