import 'dart:convert';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_event.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_state.dart';
import 'package:ekisan_credit/model/response/get_farmer_by_id_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';

class GetFarmerBloc
    extends Bloc<GetFarmerEvent, GetFarmerState> {
  ApiService apiService = ApiService();
  GetFarmerByIdResponseModel getFarmerResponseModel =
  GetFarmerByIdResponseModel();
  late CommonResponseModel? commonResponseModel;

   Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }

  GetFarmerBloc() : super(GetFarmerInitial()) {
    on<GetFarmerDetails>((event, emit) async {
      String? userId = await loadData();
      try {
        emit(GetFarmerLoading());
        final response =
        await apiService.newApiCall('/party/farmer/get_by_id?userId=$userId',
            body: event.body);
        if (kDebugMode) {
          print(("Get Farmer Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if(responseData['data'] != null){
              getFarmerResponseModel =
                  GetFarmerByIdResponseModel.fromJson(responseData);
              AppSharedPreferenceHelper().saveCustomerData("farmerId", getFarmerResponseModel.data?.farmerId);
              emit(GetFarmerSuccess(
                  getFarmerDetails:
                  getFarmerResponseModel));

            }else{
              emit(GetFarmerSuccess(
                  getFarmerDetails:
                  GetFarmerByIdResponseModel()));
            }

          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetFarmerFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetFarmerFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetFarmerFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          rethrow;
          print(err);
        }
      }
    });
    on<ResetFarmerDetails>((event, emit) {
      getFarmerResponseModel = GetFarmerByIdResponseModel();  // Reset to initial state
      emit(GetFarmerInitial());  // Emit an initial state to refresh UI
    });
  }

}
