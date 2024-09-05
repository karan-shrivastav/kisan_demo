import 'package:equatable/equatable.dart';

abstract class LoanAssetsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLoanAssetsDetails extends LoanAssetsEvent {
  final String loanId;
  GetLoanAssetsDetails({required this.loanId});
  @override
  List<Object?> get props => [loanId];
}


