import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/otp_aadhar_response_model.dart';

abstract class SendOTPAdharState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOTPAdharInitial extends SendOTPAdharState {}

class SendOTPAdharLoading extends SendOTPAdharState {}

class SendOTPAdharSuccess extends SendOTPAdharState {
  final OtpAadharResponseModel otpAadharResponseModel;

  SendOTPAdharSuccess({required this.otpAadharResponseModel});

  @override
  List<Object?> get props => [otpAadharResponseModel];
}

class SendOTPAdharFail extends SendOTPAdharState {
  final CommonResponseModel commonResponseModel;
  SendOTPAdharFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
