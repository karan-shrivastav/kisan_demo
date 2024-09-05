import 'dart:convert';


import 'package:ekisan_credit/bloc/loan_count/loan_count_event.dart';
import 'package:ekisan_credit/bloc/loan_count/loan_count_state.dart';
import 'package:ekisan_credit/model/response/loan_count_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import '../../Utils/shared_preference_helper.dart';

import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';

class LoanCountBloc extends Bloc<LoanCountEvent, LoanCountState> {
  ApiService apiService = ApiService();
  LoanCountResponseModel loanCountResponseModel = LoanCountResponseModel();

  Future<String?> getUserId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }

  late CommonResponseModel? commonResponseModel;

  LoanCountBloc() : super(GetLoanCountInitial()) {
    on<GetLoanCount>((event, emit) async {
      try {
        String? userId = await getUserId();
        emit(GetLoanCountLoading());
        final response = await apiService.newApiCall(
          '/report/dashbord/get_all_count?status=en',
        );
        if (kDebugMode) {
          print(("Get laon data  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            loanCountResponseModel =
                LoanCountResponseModel.fromJson(responseData);
            emit(GetLoanCountSuccess(
                loanCountResponseModel: loanCountResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetLoanCountFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetLoanCountFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetLoanCountFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    // on<ResetFarmerDetails>((event, emit) {
    //   getFarmerResponseModel = GetFarmerByIdResponseModel();  // Reset to initial state
    //   emit(GetFarmerInitial());  // Emit an initial state to refresh UI
    // });
  }
}
