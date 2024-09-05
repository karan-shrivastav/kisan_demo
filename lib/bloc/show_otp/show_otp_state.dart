import 'package:ekisan_credit/model/response/common_response_model.dart';
import 'package:ekisan_credit/model/response/show_otp_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class ShowOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowOtpInitial extends ShowOtpState{}
class ShowOtpLoading extends ShowOtpState {}

class ShowOtpSuccess extends ShowOtpState {
  final ShowOtpResponseModel showOtpResponseModel;

  ShowOtpSuccess({required this.showOtpResponseModel});

  @override
  List<Object?> get props => [showOtpResponseModel];
}

class ShowOtpFail extends ShowOtpState {
  final CommonResponseModel commonResponseModel;
  ShowOtpFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
