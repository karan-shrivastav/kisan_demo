
import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/login_verify_otp_response_model.dart';
import '../../model/response/send_otp_response_model.dart';

abstract class SendOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOtpNewInitial extends SendOtpState {}

class GetOtpNewLoading extends SendOtpState {}

class GetOtpNewSuccess extends SendOtpState {
  final SendOtpNewResponseModel sendOtpNewResponseModel;

  GetOtpNewSuccess({required this.sendOtpNewResponseModel});

  @override
  List<Object?> get props => [sendOtpNewResponseModel];
}

class GetOtpNewFail extends SendOtpState {
  final CommonResponseModel commonResponseModel;

  GetOtpNewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}

class VerifyOtpInitial extends SendOtpState {}

class VerifyOtpLoading extends SendOtpState {}

class VerifyOtpSuccess extends SendOtpState {
  final CommonResponseModel commonResponseModel;

  VerifyOtpSuccess({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}

class VerifyOtpFail extends SendOtpState {
  final CommonResponseModel commonResponseModel;

  VerifyOtpFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}

class ChangePasswordInitial extends SendOtpState {}
class ChangePasswordLoading extends SendOtpState {}
class ChangePasswordSuccess extends SendOtpState {
  final CommonResponseModel commonResponseModel;
  ChangePasswordSuccess({required this.commonResponseModel});
}
class ChangePasswordFail extends SendOtpState {
  final CommonResponseModel commonResponseModel;
  ChangePasswordFail({required this.commonResponseModel});
}

class LoginVerifyOtpInitial extends SendOtpState{

}
class LoginVerifyOtpLoading extends SendOtpState{

}
class LoginVerifyOtpSuccess extends SendOtpState{
  final LoginVerifyOtpResponseModel loginVerifyOtpResponseModel;
  LoginVerifyOtpSuccess({required this.loginVerifyOtpResponseModel});
  @override
  List<Object?> get props => [loginVerifyOtpResponseModel];

}
class LoginVerifyOtpFail extends SendOtpState{
   final CommonResponseModel commonResponseModel;
   LoginVerifyOtpFail({required this.commonResponseModel});
}