import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/lovtype_type_response_model.dart';
import '../../services/toast_alert.dart';
import 'lovs_type_data_event.dart';
import 'lovs_type_data_state.dart';


class GetLovsTypeDataNewBloc
    extends Bloc<LovsTypeDataNewEvent, GetLovsTypeDataNewState> {
  ApiService apiService = ApiService();
  LovsTypeModel getLovsTypeResponseModel =
  LovsTypeModel();
  late CommonResponseModel? commonResponseModel;

  GetLovsTypeDataNewBloc() : super(GetLovsTypeDataInitial()) {
    on<GetLovsTypeDataNewList>((event, emit) async {
      try {
        emit(GetLovsTypeDataLoading());
        final response =
        await apiService.apiCallTypeList('/master/lovs/get_by_types',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get LovsType Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getLovsTypeResponseModel =
                LovsTypeModel.fromJson(responseData);
            emit(GetLovsTypeDataSuccess(
                lovsTypeResponseModel:
                getLovsTypeResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetLovsTypeDataFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetLovsTypeDataFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetLovsTypeDataFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
