import 'dart:convert';

import 'package:ekisan_credit/bloc/register_farmer/register_farmer_event.dart';
import 'package:ekisan_credit/bloc/register_farmer/register_farmer_state.dart';
import 'package:ekisan_credit/model/response/register_farmer_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/response/common_response_model.dart';
import '../../services/api_service.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';

class RegisterFarmerBloc extends Bloc<RegisterFarmerEvent, RegisterFarmerState>{
  ApiService apiService = ApiService();
  Future<String?> userIdData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }
  late CommonResponseModel commonResponseModel;
  RegisterFarmerResponseModel registerFarmerResponseModel = RegisterFarmerResponseModel();
  RegisterFarmerBloc() : super(RegisterFarmerInitial()) {
    on<RegisterFarmer>((event, emit) async {
      try {
        emit(RegisterFarmerLoading());
        final response = await apiService.sendOtpApi('/auth/user/reg_farmer',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Send otp    ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            registerFarmerResponseModel = RegisterFarmerResponseModel.fromJson(responseData);
            emit(RegisterFarmerSuccess(registerFarmerResponseModel: registerFarmerResponseModel));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(RegisterFarmerFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(RegisterFarmerFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(RegisterFarmerFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<CreateFarmerUserInfo>((event, emit) async {

      String? userId = await userIdData();
      if (kDebugMode) {
        print("UserId");
      }
      if (kDebugMode) {
        print(userId);
      }
      if (kDebugMode) {
        print("UserId");
      }
      try {
        emit(CreateFarmerUserInfoLoading());
        final response = await apiService.newApiCallTypePost('/party/farmer/save_user_profile?farmerId=&userId=$userId',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print((" Create  Farmer User Info ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            commonResponseModel =  CommonResponseModel(
                statusCode: responseData["status"], message: responseData["message"]);
            emit(CreateFarmerUserInfoSuccess(commonResponseModel: commonResponseModel));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(CreateFarmerUserInfoFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(CreateFarmerUserInfoFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(CreateFarmerUserInfoFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}