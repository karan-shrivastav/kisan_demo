import 'package:equatable/equatable.dart';

abstract class ShowOtpEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ShowOtp extends ShowOtpEvent{
  final Map<String, dynamic> bodyRequest;
  ShowOtp({required this.bodyRequest});
}