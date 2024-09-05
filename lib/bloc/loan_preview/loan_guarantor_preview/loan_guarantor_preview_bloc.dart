import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';

import '../../../Services/api_service.dart';
import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_guarantor_preview_response_model.dart';
import '../../../services/toast_alert.dart';
import 'loan_guarantor_preview_event.dart';
import 'loan_guarantor_preview_state.dart';

class LoanDetailsNewBloc
    extends Bloc<LoanNewDetailsEvent, LoanNewDetailsState> {
  ApiService apiService = ApiService();
  LoanNewDetailsResponseModel loanNewDetailsResponseModel =
      LoanNewDetailsResponseModel();
  late CommonResponseModel? commonResponseModel;

  LoanDetailsNewBloc() : super(LoanNewDetailsStateInitial()) {
    on<GetNewLoanDetails>((event, emit) async {
      if (kDebugMode) {
        print(
            "Api Calloing of laons_  /loan/master/loans_detail?id=${event.bodyRequest["masterId"]}}");
      }
      try {
        emit(LoanNewDetailsStateLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loans_detail?id=${event.bodyRequest["masterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get Loan details --response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            loanNewDetailsResponseModel =
                LoanNewDetailsResponseModel.fromJson(responseData);
            emit(LoanNewDetailsStateSuccess(
                loanNewDetailsResponseModel: loanNewDetailsResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(LoanNewDetailsStateFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(LoanNewDetailsStateFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(LoanNewDetailsStateFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
