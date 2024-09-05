import 'package:equatable/equatable.dart';

abstract class LoanCountEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetLoanCount extends LoanCountEvent{
  final Map<String , dynamic> bodyRequest ;
  GetLoanCount({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}