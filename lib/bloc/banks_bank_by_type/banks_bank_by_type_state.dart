import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_bank_type_type_response_model.dart';

abstract class BanksNewBankByTypeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BanksNewBankByTypeInitial extends BanksNewBankByTypeState {}

class BanksNewBankByTypeLoading extends BanksNewBankByTypeState {}

class BanksNewBankByTypeSuccess extends BanksNewBankByTypeState {
  final GetBanksTypeTypeResponseModel getBanksTypeTypeResponseModel;

  BanksNewBankByTypeSuccess({required this.getBanksTypeTypeResponseModel});
}

class BanksNewBankByTypeFail extends BanksNewBankByTypeState {
  final CommonResponseModel commonResponseModel;

  BanksNewBankByTypeFail({required this.commonResponseModel});
}
