import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/update_contact_information_response_model.dart';

abstract class UpdateContactInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateContactInfoStateInitial extends UpdateContactInfoState {}

class UpdateContactInfoStateLoading extends UpdateContactInfoState {}

class UpdateContactInfoStateSuccess extends UpdateContactInfoState {
  final UpdateContactInformationResponseModel updateContactInfoModel;

  UpdateContactInfoStateSuccess({required this.updateContactInfoModel});

  @override
  List<Object?> get props => [updateContactInfoModel];
}

class UpdateContactInfoStateFail extends UpdateContactInfoState {
  final CommonResponseModel commonResponseModel;
  UpdateContactInfoStateFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
