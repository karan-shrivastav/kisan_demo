import 'dart:convert';
import 'package:ekisan_credit/bloc/send_adhar_otp/send_otp_adhar_event.dart';
import 'package:ekisan_credit/bloc/send_adhar_otp/send_otp_adhar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/otp_aadhar_response_model.dart';
import '../../services/toast_alert.dart';

class SendOTPAadharBloc extends Bloc<SendOTPAdharEvent, SendOTPAdharState> {
  ApiService apiService = ApiService();
  OtpAadharResponseModel otpAadharResponseModel = OtpAadharResponseModel();
  late CommonResponseModel? commonResponseModel;

  SendOTPAadharBloc() : super(SendOTPAdharInitial()) {
    on<GetAdharOTP>((event, emit) async {
      try {
        emit(SendOTPAdharLoading());
        final response = await apiService.sendOtpApi(
          '/auth/aadhar/v1/joint_applicant_otp?aadharNo=${event.aadharNumber}&consent=true',
        );
        if (kDebugMode) {
          print('________________________________________________8');
          print(("Get Aadhar Data : ${response.body}"));
          print('________________________________________________8');
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['dataList'] != null) {
              otpAadharResponseModel =
                  OtpAadharResponseModel.fromJson(responseData);

              emit(SendOTPAdharSuccess(
                  otpAadharResponseModel: otpAadharResponseModel));
            } else {
              emit(SendOTPAdharSuccess(
                  otpAadharResponseModel: otpAadharResponseModel));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SendOTPAdharFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SendOTPAdharFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(SendOTPAdharFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
