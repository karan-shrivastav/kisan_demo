
import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/loan_list_response_model.dart';

abstract class LoanListStateData extends Equatable {
  @override
  List<Object?> get props => [];
}
class GetLoanListInitial extends LoanListStateData{

}
class GetLoanListLoading extends LoanListStateData{

}

class GetLoanListSuccess extends LoanListStateData{
  final GetLoanListResponseModel getLoanListResponseModel ;
  GetLoanListSuccess({required this.getLoanListResponseModel});

}
class GetLoanListFail extends LoanListStateData{
  final CommonResponseModel commonResponseModel ;
  GetLoanListFail({required this.commonResponseModel});

}