import 'package:equatable/equatable.dart';

abstract class GetLoanBasicEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBasicLoanResponse extends GetLoanBasicEvent {
  final String loanId;
  GetBasicLoanResponse({required this.loanId});
  @override
  List<Object?> get props => [loanId];
}
