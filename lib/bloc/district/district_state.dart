import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_district_response_model.dart';

abstract class DistrictStateNew extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDistrictInitial extends DistrictStateNew {}

class GetDistrictLoading extends DistrictStateNew {}

class GetDistrictSuccess extends DistrictStateNew {
  final GetDistrictResponseModel getDistrictResponseModel;

  GetDistrictSuccess({required this.getDistrictResponseModel});

  @override
  List<Object?> get props => [getDistrictResponseModel];
}

class GetDistrictFail extends DistrictStateNew {
  final CommonResponseModel commonResponseModel;

  GetDistrictFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
