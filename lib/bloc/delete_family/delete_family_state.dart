import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/delete_family_response_model.dart';
import '../../model/response/update_personal_info_model.dart';

abstract class DeleteFamilyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteFamilyInitial extends DeleteFamilyState {}

class DeleteFamilyLoading extends DeleteFamilyState {}

class DeleteFamilySuccess extends DeleteFamilyState {
  final DeleteFamilyReponseModel deleteFamilyResponseModel;

  DeleteFamilySuccess({required this.deleteFamilyResponseModel});

  @override
  List<Object?> get props => [deleteFamilyResponseModel];
}

class DeleteFamilyFail extends DeleteFamilyState {
  final CommonResponseModel commonResponseModel;
  DeleteFamilyFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
