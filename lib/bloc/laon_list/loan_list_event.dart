import 'package:equatable/equatable.dart';

abstract class LoanListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetLoanList extends LoanListEvent{
  final Map<String, dynamic> loanListRequest;
  GetLoanList({required this.loanListRequest});
  @override
  List<Object?> get props => [loanListRequest];
}