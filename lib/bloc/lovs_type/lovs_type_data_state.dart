
import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/lovtype_type_response_model.dart';

abstract class GetLovsTypeDataNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLovsTypeDataInitial extends GetLovsTypeDataNewState {}

class GetLovsTypeDataLoading extends GetLovsTypeDataNewState {}

class GetLovsTypeDataSuccess extends GetLovsTypeDataNewState {
  final LovsTypeModel lovsTypeResponseModel;

  GetLovsTypeDataSuccess({required this.lovsTypeResponseModel});

  @override
  List<Object?> get props => [lovsTypeResponseModel];
}

class GetLovsTypeDataFail extends GetLovsTypeDataNewState {
  final CommonResponseModel commonResponseModel;

  GetLovsTypeDataFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
