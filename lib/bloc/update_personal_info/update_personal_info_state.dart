import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/update_personal_info_model.dart';

abstract class UpdatePersonalInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePersonalInfoInitial extends UpdatePersonalInfoState {}

class UpdatePersonalInfoLoading extends UpdatePersonalInfoState {}

class UpdatePersonalInfoSuccess extends UpdatePersonalInfoState {
  final UpdatePersonalInfoModel updatePersonalInfoModel;

  UpdatePersonalInfoSuccess({required this.updatePersonalInfoModel});

  @override
  List<Object?> get props => [updatePersonalInfoModel];
}

class UpdatePersonalInfoFail extends UpdatePersonalInfoState {
  final CommonResponseModel commonResponseModel;
  UpdatePersonalInfoFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
