import 'dart:convert';
import 'package:ekisan_credit/bloc/update_personal_info/update_personal_info_event.dart';
import 'package:ekisan_credit/bloc/update_personal_info/update_personal_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/update_personal_info_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';

class UpdatePersonalInfoBloc
    extends Bloc<UpdatePersonalInfoEvent, UpdatePersonalInfoState> {
  ApiService apiService = ApiService();
  UpdatePersonalInfoModel getFarmerResponseModel =
  UpdatePersonalInfoModel();
  late CommonResponseModel? commonResponseModel;

   Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }

  UpdatePersonalInfoBloc() : super(UpdatePersonalInfoInitial()) {
    on<UpdatePersonalInfoDetails>((event, emit) async {
      String? userId = await loadData();
      try {
        emit(UpdatePersonalInfoLoading());
        final response =
        await apiService.newApiCallTypePost('/party/farmer/save_user_profile?farmerId=${event.farmerId}&userId=$userId',
            body: event.body);
        if (kDebugMode) {
          print(("Get LovsType Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
             ToastAlert(responseData["message"]);
            getFarmerResponseModel =
                UpdatePersonalInfoModel.fromJson(responseData);
            emit(UpdatePersonalInfoSuccess(
                updatePersonalInfoModel:
                getFarmerResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(UpdatePersonalInfoFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(UpdatePersonalInfoFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(UpdatePersonalInfoFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
