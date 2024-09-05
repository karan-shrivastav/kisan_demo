import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ekisan_credit/bloc/otp/send_otp_event.dart';
import 'package:ekisan_credit/bloc/otp/send_otp_state.dart';
import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/login_verify_otp_response_model.dart';
import '../../model/response/send_otp_response_model.dart';
import '../../services/api_service.dart';
import '../../services/toast_alert.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  ApiService apiService = ApiService();
  late CommonResponseModel commonResponseModel;
  SendOtpNewResponseModel sendOtpNewResponseModel = SendOtpNewResponseModel();
  LoginVerifyOtpResponseModel loginVerifyOtpResponseModel =
      LoginVerifyOtpResponseModel();

  SendOtpBloc() : super(GetOtpNewInitial()) {
    on<GetNewOtp>((event, emit) async {
      try {
        emit(GetOtpNewLoading());
        final response = await apiService.sendOtpApi('/auth/send_otp',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Send otp    ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            sendOtpNewResponseModel =
                SendOtpNewResponseModel.fromJson(responseData);
            emit(GetOtpNewSuccess(
                sendOtpNewResponseModel: sendOtpNewResponseModel));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(
              GetOtpNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong'),
              ),
            );
            ToastAlert(responseData["message"]);
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetOtpNewFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetOtpNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<VerifyOtp>((event, emit) async {
      try {
        emit(VerifyOtpLoading());
        final response = await apiService.sendOtpApi('/auth/forget_password',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Forgot password ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            // commonResponseModel = CommonResponseModel.fromJson(responseData);
            emit(VerifyOtpSuccess(
                commonResponseModel: CommonResponseModel(
                    statusCode: 400, message: responseData["message"])));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(VerifyOtpFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(VerifyOtpFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(VerifyOtpFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<ChangePassword>((event, emit) async {
      try {
        emit(ChangePasswordInitial());
        final response = await apiService.newApiCallTypePost(
            '/auth/user/change_password',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Change password ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            // commonResponseModel = CommonResponseModel.fromJson(responseData);
            emit(ChangePasswordSuccess(
                commonResponseModel: CommonResponseModel(
                    statusCode: 400, message: responseData["message"])));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(ChangePasswordFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(ChangePasswordFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(ChangePasswordFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<ResetChangePassword>((event, emit) {
      emit(ChangePasswordInitial());
    });
    on<ResetForgetPassword>((event, emit) {
      emit(GetOtpNewInitial());
    });

    /******************** Login Verify ******************************/
    on<LoginVerifyOtp>((event, emit) async {
      try {
        emit(LoginVerifyOtpLoading());
        final response = await apiService.sendOtpApi('/auth/login_verify_otp',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Forgot password ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            loginVerifyOtpResponseModel =
                LoginVerifyOtpResponseModel.fromJson(responseData);
            emit(LoginVerifyOtpSuccess(
                loginVerifyOtpResponseModel: loginVerifyOtpResponseModel));
            AppSharedPreferenceHelper().saveCustomerData(
                "token", loginVerifyOtpResponseModel.data?.idToken);
            AppSharedPreferenceHelper().saveCustomerData(
                "refreshToken", loginVerifyOtpResponseModel.data?.refreshToken);
            AppSharedPreferenceHelper().saveCustomerData(
                "userId", loginVerifyOtpResponseModel.data?.userId.toString());
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(VerifyOtpFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(VerifyOtpFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(VerifyOtpFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
