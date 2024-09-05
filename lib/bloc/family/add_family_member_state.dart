import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddFamilyMemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddFamilyMemberInitial extends AddFamilyMemberState {}

class AddFamilyMemberLoading extends AddFamilyMemberState {}

class AddFamilyMemberSuccess extends AddFamilyMemberState {
  final CommonResponseModel commonResponseModel;

  AddFamilyMemberSuccess({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}

class AddFamilyMemberFail extends AddFamilyMemberState {
  final CommonResponseModel commonResponseModel;

  AddFamilyMemberFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
