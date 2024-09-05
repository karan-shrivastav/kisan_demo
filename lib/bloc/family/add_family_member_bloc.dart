import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';
import 'add_family_member_event.dart';
import 'add_family_member_state.dart';

class AddFamilyMemberBloc
    extends Bloc<AddFamilyMemberEvent, AddFamilyMemberState> {
  ApiService apiService = ApiService();

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }

  late CommonResponseModel? commonResponseModel;

  AddFamilyMemberBloc() : super(AddFamilyMemberInitial()) {
    on<AddFamilyMember>((event, emit) async {
      String? userId = await getFarmerId();

      if (kDebugMode) {
        print("BODY REQUEST");
      }
      if (kDebugMode) {
        print(event.bodyRequest);
      }
      if (kDebugMode) {
        print("BODY REQUEST");
      }
      try {
        emit(AddFamilyMemberLoading());
        final response = await apiService.newApiCallTypeListPost(
            '/party/farmer/save_nominee_detail/$userId',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Add Farmer Family Member ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            commonResponseModel = CommonResponseModel(
                statusCode: responseData['status'],
                message: responseData['message']);
            emit(AddFamilyMemberSuccess(
                commonResponseModel: CommonResponseModel(
                    statusCode: responseData['status'],
                    message: responseData['message'])));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(AddFamilyMemberFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(AddFamilyMemberFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(AddFamilyMemberFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
