import 'package:equatable/equatable.dart';

class ApplyLoanRequestEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ApplyLoanRequest extends ApplyLoanRequestEvent{
  final Map<String, dynamic> requestBody;
  ApplyLoanRequest({required this.requestBody});
}
