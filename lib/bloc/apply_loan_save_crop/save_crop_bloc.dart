import 'dart:convert';


import 'package:ekisan_credit/bloc/apply_loan_save_crop/save_crop_event.dart';
import 'package:ekisan_credit/bloc/apply_loan_save_crop/save_crop_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/save_crop_resposne_model.dart';
import '../../services/toast_alert.dart';



class SaveCropNewBloc extends Bloc<SaveCropNewEvent, SaveCropNewState> {
  ApiService apiService = ApiService();
  SaveCropResponseModel saveCropResponseModel = SaveCropResponseModel();
  late CommonResponseModel? commonResponseModel;

  SaveCropNewBloc() : super(SaveCropNewInitial()) {
    on<SaveCropNew>((event, emit) async {
      try {
        if (kDebugMode) {
          print(event.requestBody);
        }
        emit(SaveCropNewLoading());
        final response = await apiService
            .newApiCallTypePost('/loan/master/save', body: event.requestBody);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Save Crop response  ${response.body}"));
        }

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          if (responseData['status'] == 200) {
            ToastAlert(responseData["message"]);
            saveCropResponseModel =
                SaveCropResponseModel.fromJson(responseData);
            emit(SaveCropNewSuccess(
                saveCropResponseModel: saveCropResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SaveCropNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SaveCropNewFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(SaveCropNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    /*********** Initiate State *******************/

    on<SaveCropNewInitiate>((event, emit) async {
      emit(SaveCropNewInitial());
    });
  }
}
