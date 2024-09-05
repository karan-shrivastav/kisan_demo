
import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_village_response_model.dart';

abstract class GetVillageDataNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetVillageInitial extends GetVillageDataNewState {}

class GetVillageLoading extends GetVillageDataNewState {}

class GetVillageSuccess extends GetVillageDataNewState {
  final GetVillageResponseModel getVillageResponseModel;

  GetVillageSuccess({required this.getVillageResponseModel});

  @override
  List<Object?> get props => [getVillageResponseModel];
}

class GetVillageFail extends GetVillageDataNewState {
  final CommonResponseModel commonResponseModel;
  GetVillageFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
