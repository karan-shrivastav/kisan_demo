import 'package:equatable/equatable.dart';

import '../../model/response/add_land_response_model.dart';
import '../../model/response/common_response_model.dart';

abstract class AddLandDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddLandDataInitial extends AddLandDataState {}

class AddLandDataLoading extends AddLandDataState {}

class AddLandDataSuccess extends AddLandDataState {
  final AddLandResponseModel addLandResponseModel;
  AddLandDataSuccess({required this.addLandResponseModel});
  @override
  List<Object?> get props => [addLandResponseModel];
}

class AddLandDataFail extends AddLandDataState {
  final CommonResponseModel commonResponseModel;
  AddLandDataFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
