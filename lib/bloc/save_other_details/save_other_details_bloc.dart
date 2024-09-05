import 'dart:convert';

import 'package:ekisan_credit/bloc/save_other_details/save_other_details_event.dart';
import 'package:ekisan_credit/bloc/save_other_details/save_other_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/save_other_details_response_model.dart';
import '../../services/toast_alert.dart';

class SaveOtherDetailsNewBloc
    extends Bloc<SaveOtherDetailsNewEvent, SaveOtherDetailsNewState> {
  ApiService apiService = ApiService();
  late CommonResponseModel? commonResponseModel;
  SaveOtherDetailsSuccessResponseModel saveOtherDetailsSuccessResponseModel =
      SaveOtherDetailsSuccessResponseModel();

  SaveOtherDetailsNewBloc() : super(SaveOtherDetailsNewInitial()) {
    on<SaveOtherDetailsNew>((event, emit) async {
      try {
        emit(SaveOtherDetailsNewLoading());
        final response = await apiService.newApiCallTypePost(
            '/loan/master/save_loan_master_income_details/${event.bodyRequest["masterId"]}',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Save OtherDetails response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            saveOtherDetailsSuccessResponseModel =
                SaveOtherDetailsSuccessResponseModel.fromJson(responseData);
            emit(SaveOtherDetailsNewSuccess(
                saveOtherDetailsSuccessResponseModel:
                    saveOtherDetailsSuccessResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SaveOtherDetailsNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SaveOtherDetailsNewFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(SaveOtherDetailsNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<ResetStateOfSaveOtherDetailsNew>((event, emit) {
      emit(SaveOtherDetailsNewInitial());
    });
  }
}
