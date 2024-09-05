import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_guarantors_response_model.dart';
import '../../services/toast_alert.dart';
import 'loan_guarantor_event.dart';
import 'loan_guarantor_state.dart';

class LoanGuarantorBloc extends Bloc<LoanGuarantorEvent, LoanGuarantorState> {
  ApiService apiService = ApiService();
  LoanGuarantorResponseModel loanGuarantorResponseModel =
      LoanGuarantorResponseModel();
  late CommonResponseModel? commonResponseModel;

  LoanGuarantorBloc() : super(LoanGuarantorInitial()) {
    on<GetLoanGuarantorDetails>((event, emit) async {
      try {
        emit(LoanGuarantorLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loans_detail?id=${event.loanId}',
        );
        if (kDebugMode) {
          print('________________________________________________8');
          print(("Get Guarantor's Data : ${response.body}"));
          print('________________________________________________8');
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data'] != null) {
              loanGuarantorResponseModel =
                  LoanGuarantorResponseModel.fromJson(responseData);

              emit(LoanGuarantorSuccess(
                  loanGuarantorResponseModel: loanGuarantorResponseModel));
            } else {
              emit(LoanGuarantorSuccess(
                  loanGuarantorResponseModel: loanGuarantorResponseModel));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(LoanGuarantorFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(LoanGuarantorFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(LoanGuarantorFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
