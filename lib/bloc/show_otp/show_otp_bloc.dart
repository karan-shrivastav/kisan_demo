import 'dart:convert';

import 'package:ekisan_credit/bloc/show_otp/show_otp_event.dart';
import 'package:ekisan_credit/bloc/show_otp/show_otp_state.dart';
import 'package:ekisan_credit/model/response/show_otp_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/response/common_response_model.dart';
import '../../services/api_service.dart';
import '../../services/toast_alert.dart';

class ShowOtpBloc extends Bloc<ShowOtpEvent, ShowOtpState> {
  ApiService apiService = ApiService();
  late CommonResponseModel commonResponseModel;
  ShowOtpResponseModel showOtpResponseModel = ShowOtpResponseModel();

  ShowOtpBloc() : super(ShowOtpInitial()) {
    on<ShowOtp>((event, emit) async {
      try {
        emit(ShowOtpLoading());
        final response = await apiService.sendOtpApi('/auth/user/get_otp_by_mobileNo?mobileNo=${event.bodyRequest["mobileNo"]}',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Send otp    ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            showOtpResponseModel = ShowOtpResponseModel.fromJson(responseData);
            emit(ShowOtpSuccess(showOtpResponseModel: showOtpResponseModel));
            ToastAlert(responseData["dataList"][0]["code"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(ShowOtpFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(ShowOtpFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(ShowOtpFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
