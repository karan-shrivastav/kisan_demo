import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/create_farmer_address_response_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';
import 'add_address_event.dart';
import 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent,AddAddressState>{
  ApiService apiService = ApiService();
  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('userId');
  }
  CreateFarmerAddressResponseModel createFarmerAddressResponseModel = CreateFarmerAddressResponseModel();
  late CommonResponseModel? commonResponseModel;
  AddAddressBloc() : super(AddAddressInitial()) {
    on<AddAddress>((event, emit) async {
      String? userId = await loadData();

      print("BODYREQUEST");
      print(event.bodyRequest);
      print("BODYREQUEST");
      try {
        emit(AddAddressLoading());
        final response = await apiService.newApiCallTypeListPost(
          '/party/farmer/save_address?userId=$userId&bothAddressSame=${event.isSameAddress}',
          body: event.bodyRequest
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Add Address Response ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            createFarmerAddressResponseModel =
                CreateFarmerAddressResponseModel.fromJson(responseData);
            emit(AddAddressSuccess(
                createFarmerAddressResponseModel: createFarmerAddressResponseModel));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(AddAddressFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(AddAddressFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(AddAddressFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });

  }
}