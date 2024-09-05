import 'dart:convert';

import 'package:ekisan_credit/bloc/check_ekyc/check_ekyc_event.dart';
import 'package:ekisan_credit/bloc/check_ekyc/check_ekyc_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import '../../Utils/shared_preference_helper.dart';
import '../../model/response/check_kyc_response_model.dart';
import '../../model/response/check_side_bar_response_model.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';


class CheckEkyCBloc extends Bloc<CheckEkyCEvent, CheckEkyCState> {
  ApiService apiService = ApiService();
  CheckKycResponseModel checkKycResponseModel = CheckKycResponseModel();
  Future<String?> getUserId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }
  late CommonResponseModel? commonResponseModel;

  CheckEkyCBloc() : super(CheckEkyCStateInitial()) {
    on<CheckEkyC>((event, emit) async {
      try {
        String? userId = await getUserId();
        emit(CheckEkyCStateLoading());
        final response = await apiService.newApiCall(
          '/auth/aadhar/v1/check_kyc?userId=$userId',
        );
        if (kDebugMode) {
          print(("Get Aadhar data  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data'] != null) {
              checkKycResponseModel =
                  CheckKycResponseModel.fromJson(responseData);
              emit(CheckEkyCStateSuccess(
                  checkKycResponseModel: checkKycResponseModel));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(CheckEkyCStateFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(CheckEkyCStateFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(CheckEkyCStateFail(
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
