import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_crop_name_list_response_model.dart';
import '../../services/toast_alert.dart';
import 'crop_name_event.dart';
import 'crop_name_state.dart';

class CropNameNewBloc extends Bloc<CropNameNewEvent,CropNameNewState>{
  ApiService apiService = ApiService();
  GetCropNameListResponseModel getCropNameListResponseModel = GetCropNameListResponseModel();
  late CommonResponseModel? commonResponseModel;
  CropNameNewBloc():super(GetCropNameNewInitial()){
    on<GetCropNameList>((event, emit) async {
      try {
        emit(GetCropNameNewLoading());
        final response =
        await apiService.newApiCallTypePost('/master/banksof/get',
            body: event.cropRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get Crop Name List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getCropNameListResponseModel =
                GetCropNameListResponseModel.fromJson(responseData);
            emit(GetCropNameNewSuccess(
                getCropNameListResponseModel:
                getCropNameListResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetCropNameNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetCropNameNewFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetCropNameNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}