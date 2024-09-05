import 'dart:convert';

import 'package:ekisan_credit/bloc/save_land_details/save_land_details_event.dart';
import 'package:ekisan_credit/bloc/save_land_details/save_land_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/save_land_details_resposne_model.dart';
import '../../services/toast_alert.dart';

class SaveLandDetailsNewBloc
    extends Bloc<SaveLandDetailsNewEvent, SaveLandDetailsNewState> {
  ApiService apiService = ApiService();
  SaveLoanDetailsNewResponseModel saveLoanDetailsNewResponseModel =
      SaveLoanDetailsNewResponseModel();
  late CommonResponseModel? commonResponseModel;

  SaveLandDetailsNewBloc() : super(SaveLandDetailsNewStateInitial()) {
    on<SaveLandDetailsNew>((event, emit) async {
      try {
        emit(SaveLandDetailsNewStateLoading());
        final response = await apiService.newApiCallTypePost(
            '/loan/master/save_land_details/${event.requestBody["masterId"]}',
            body: event.requestBody);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Save land details  ${response.body}"));
        }

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          if (responseData['status'] == 200) {
            saveLoanDetailsNewResponseModel =
                SaveLoanDetailsNewResponseModel.fromJson(responseData);
            emit(SaveLandDetailsNewStateSuccess(
                saveLoanDetailsNewResponseModel:
                    saveLoanDetailsNewResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SaveLandDetailsNewStateFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SaveLandDetailsNewStateFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(SaveLandDetailsNewStateFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
