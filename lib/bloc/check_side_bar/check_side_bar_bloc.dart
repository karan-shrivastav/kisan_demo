import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import '../../Utils/shared_preference_helper.dart';
import '../../model/response/check_side_bar_response_model.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import 'check_side_bar_event.dart';
import 'check_side_bar_state.dart';

class CheckSideBarBloc extends Bloc<CheckSidebarEvent, CheckSideBarState> {
  ApiService apiService = ApiService();
  CheckSideBarResponseModel checkSideBarResponseModel =
      CheckSideBarResponseModel();
  late CommonResponseModel? commonResponseModel;

  CheckSideBarBloc() : super(CheckSideBarInitial()) {
    on<GetSidebar>((event, emit) async {
      try {
        emit(CheckSidebarLoading());
        final response = await apiService.newApiCall(
          '/report/dashbord/side_bar_view',
        );
        if (kDebugMode) {
          print(("Get side bar data  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data'] != null) {
              checkSideBarResponseModel =
                  CheckSideBarResponseModel.fromJson(responseData);
              emit(CheckSideBarSuccess(
                  checkSideBarResponseModel: checkSideBarResponseModel));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(CheckSideBarFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(CheckSideBarFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(CheckSideBarFail(
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
