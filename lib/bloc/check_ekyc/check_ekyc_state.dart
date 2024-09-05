import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/check_kyc_response_model.dart';

abstract class CheckEkyCState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckEkyCStateInitial extends CheckEkyCState {}

class CheckEkyCStateLoading extends CheckEkyCState {}

class CheckEkyCStateSuccess extends CheckEkyCState {
  final CheckKycResponseModel checkKycResponseModel;

  CheckEkyCStateSuccess({required this.checkKycResponseModel});

  @override
  List<Object?> get props => [checkKycResponseModel];
}

class CheckEkyCStateFail extends CheckEkyCState {
  final CommonResponseModel commonResponseModel;

  CheckEkyCStateFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
