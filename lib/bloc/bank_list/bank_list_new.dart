import 'package:equatable/equatable.dart';

abstract class BankListNewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetBanNewBankList extends BankListNewEvent{
  final Map<String, dynamic> bankRequest;
  GetBanNewBankList({ required this.bankRequest});
  @override
  List<Object?> get props => [bankRequest];
}