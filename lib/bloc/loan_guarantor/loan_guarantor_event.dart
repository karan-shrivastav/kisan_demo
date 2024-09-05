import 'package:equatable/equatable.dart';

abstract class LoanGuarantorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLoanGuarantorDetails extends LoanGuarantorEvent {
  final String loanId;
  GetLoanGuarantorDetails({required this.loanId});
  @override
  List<Object?> get props => [loanId];
}
