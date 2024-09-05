import 'package:equatable/equatable.dart';

abstract class SendOtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewOtp extends SendOtpEvent {
  final Map<String, dynamic> bodyRequest;

  GetNewOtp({required this.bodyRequest});

  @override
  List<Object?> get props => [bodyRequest];
}

class VerifyOtp extends SendOtpEvent {
  final Map<String, dynamic> bodyRequest;

  VerifyOtp({required this.bodyRequest});

  @override
  List<Object?> get props => [bodyRequest];
}

class ChangePassword extends SendOtpEvent {
  final Map<String, dynamic> bodyRequest;

  ChangePassword({required this.bodyRequest});

  @override
  List<Object?> get props => [bodyRequest];
}

class ResetChangePassword extends SendOtpEvent {}

class ResetForgetPassword extends SendOtpEvent {}

class LoginVerifyOtp extends SendOtpEvent {
  final Map<String, dynamic> bodyRequest;

  LoginVerifyOtp({required this.bodyRequest});

  @override
  List<Object?> get props => [bodyRequest];
}
