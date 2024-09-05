
import 'package:equatable/equatable.dart';

abstract class LoanNewDetailsEvent extends Equatable{
  @override
  List<Object?> get props =>[];
}

class GetNewLoanDetails extends LoanNewDetailsEvent{
  final Map<String, dynamic> bodyRequest;
  GetNewLoanDetails({required this.bodyRequest});
}