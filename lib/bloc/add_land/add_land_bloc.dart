import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/add_land_response_model.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import 'add_land_event.dart';
import 'add_land_state.dart';

class AddLandDataBloc extends Bloc<AddLandDataEvent, AddLandDataState> {
  ApiService apiService = ApiService();
  AddLandResponseModel addLandResponseModel =
  AddLandResponseModel();
  late CommonResponseModel? commonResponseModel;
  AddLandDataBloc() : super(AddLandDataInitial()) {
    on<AddLandDetailsData>((event, emit) async {
      try {
        emit(AddLandDataLoading());
        final response = await apiService
            .newApiCallTypePost('/party/land_details/save', body: event.landRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Adding land data   ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            addLandResponseModel =
                AddLandResponseModel.fromJson(responseData);
            emit(AddLandDataSuccess(
                addLandResponseModel: addLandResponseModel));
            ToastAlert(responseData["message"]);
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(AddLandDataFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(AddLandDataFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(AddLandDataFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
