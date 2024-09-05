import 'package:equatable/equatable.dart';

abstract class SendOTPAdharEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAdharOTP extends SendOTPAdharEvent {
  final String aadharNumber;
  GetAdharOTP({required this.aadharNumber});
  @override
  List<Object?> get props => [aadharNumber];
}
