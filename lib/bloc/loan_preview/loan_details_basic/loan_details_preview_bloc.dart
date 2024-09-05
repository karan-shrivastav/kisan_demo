import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Services/api_service.dart';
import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_details_preview_response_model.dart';
import '../../../services/toast_alert.dart';
import 'package:flutter/foundation.dart';

import 'loan_details_preview_event.dart';
import 'loan_details_preview_state.dart';
class LoanDetailsNewPreviewBloc extends Bloc<LoanDetailsNewPreviewEvent,LoanDetailsNewPreviewState>{
  ApiService apiService = ApiService();
  LoanDetailsNewPreviewResponseModel loanDetailsNewPreviewResponseModel = LoanDetailsNewPreviewResponseModel();
  late CommonResponseModel? commonResponseModel;
  LoanDetailsNewPreviewBloc():super(LoanDetailsNewPreviewInitial()){
    on<GetLoanDetailsNewPreviewData>((event, emit) async {
      try {
        emit(LoanDetailsNewPreviewLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loan_detail?id=${event.bodyRequest["masterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get BankType  List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            loanDetailsNewPreviewResponseModel  =
                LoanDetailsNewPreviewResponseModel.fromJson(responseData);
            emit(LoanDetailsNewPreviewSuccess(
                loanDetailsNewPreviewResponseModel: loanDetailsNewPreviewResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(LoanDetailsNewPreviewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(LoanDetailsNewPreviewFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(LoanDetailsNewPreviewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }

}