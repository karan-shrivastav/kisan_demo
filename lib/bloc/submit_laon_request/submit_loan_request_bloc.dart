import 'dart:convert';

import 'package:ekisan_credit/bloc/submit_laon_request/submit_loan_request_event.dart';
import 'package:ekisan_credit/bloc/submit_laon_request/submit_loan_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/submit_loan_response_model.dart';
import '../../services/toast_alert.dart';


class SubmitLoanRequestBloc
    extends Bloc<SubmitLoanRequestEvent, SubmitLoanRequestState> {
  ApiService apiService = ApiService();
  LoanSubmitResponseModel loanSubmitResponseModel = LoanSubmitResponseModel();
  late CommonResponseModel? commonResponseModel;

  SubmitLoanRequestBloc() : super(SubmitLoanRequestNewInitial()) {
    on<SubmitLoanRequest>((event, emit) async {
      try {
        emit(SubmitLoanRequestNewLoading());
        final response = await apiService.newApiCallTypePost(
          '/loan/master/loan_submit/${event.bodyRequest["masterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(
              ("Get LoanAssetPreview Data   List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            loanSubmitResponseModel =
                LoanSubmitResponseModel.fromJson(responseData);
            ToastAlert(responseData["message"]);
            emit(SubmitLoanRequestNewSuccess(
                loanSubmitResponseModel: loanSubmitResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SubmitLoanRequestNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SubmitLoanRequestNewFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(SubmitLoanRequestNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
