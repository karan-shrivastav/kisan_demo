import 'dart:convert';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_event.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_state.dart';
import 'package:ekisan_credit/model/response/get_farmer_by_id_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_joint_applicant_response_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';
import 'get_joint_applicant_event.dart';
import 'get_joint_applicant_state.dart';

class GetJointApplicantBloc
    extends Bloc<GetJointApplicantEvent, GetJointApplicantState> {
  ApiService apiService = ApiService();
  GetJointApplicantResponseModel getJointApplicantResponseModel =
      GetJointApplicantResponseModel();
  late CommonResponseModel? commonResponseModel;

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }

  GetJointApplicantBloc() : super(GetJointApplicantInitial()) {
    on<GetJointApplicantList>((event, emit) async {
      String? farmerId = await getFarmerId();
      try {
        emit(GetJointApplicantLoading());
        final response = await apiService.newApiCallTypePost(
            '/party/joint_applicant/get_by/$farmerId?page=0&size=25&sort=id&order=desc',
            body: event.body);
        if (kDebugMode) {
          print(("Get Joint applicant ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data'] != null) {
              getJointApplicantResponseModel =
                  GetJointApplicantResponseModel.fromJson(responseData);

              emit(GetJointApplicantSuccess(
                  getJointApplicantResponseModel:
                      getJointApplicantResponseModel));
            } else {
              emit(GetJointApplicantSuccess(
                  getJointApplicantResponseModel:
                      GetJointApplicantResponseModel()));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetJointApplicantFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetJointApplicantFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetJointApplicantFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
