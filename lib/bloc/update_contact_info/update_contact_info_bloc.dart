import 'dart:convert';
import 'package:ekisan_credit/bloc/update_contact_info/update_contact_info_event.dart';
import 'package:ekisan_credit/bloc/update_contact_info/update_contact_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/update_contact_information_response_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';

class UpdateContactInfoBloc
    extends Bloc<UpdateContactInfoEvent, UpdateContactInfoState> {
  ApiService apiService = ApiService();
  UpdateContactInformationResponseModel updateContactInformationResponseModel =
  UpdateContactInformationResponseModel();
  late CommonResponseModel? commonResponseModel;

  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }

  UpdateContactInfoBloc() : super(UpdateContactInfoStateInitial()) {
    on<UpdateContactInfoDetails>((event, emit) async {
      String? userId = await loadData();
      try {
        emit(UpdateContactInfoStateLoading());
        final response =
        await apiService.newApiCallTypeListPost('/party/farmer/save_address?userId=$userId&bothAddressSame=${event.bothAddressSame}',
            body: event.body);
        if (kDebugMode) {
          print(("Get LovsType Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            ToastAlert(responseData["message"]);
            updateContactInformationResponseModel =
                UpdateContactInformationResponseModel.fromJson(responseData);
            emit(UpdateContactInfoStateSuccess(
               updateContactInfoModel: updateContactInformationResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(UpdateContactInfoStateFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(UpdateContactInfoStateFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(UpdateContactInfoStateFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
