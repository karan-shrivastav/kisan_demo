import 'package:equatable/equatable.dart';

abstract class BanksNewBankByTypeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetNewBanksBankByType extends BanksNewBankByTypeEvent{
  final Map<String, dynamic> bankRequest;
  GetNewBanksBankByType({required this.bankRequest});
  @override
  List<Object?> get props => [bankRequest];
}

