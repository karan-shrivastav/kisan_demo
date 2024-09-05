import 'package:equatable/equatable.dart';

abstract class SubmitLoanRequestEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SubmitLoanRequest extends SubmitLoanRequestEvent{
  final Map<String,dynamic> bodyRequest;
  SubmitLoanRequest({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}