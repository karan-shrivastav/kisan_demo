import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_district_response_model.dart';
import '../../services/toast_alert.dart';
import 'district_event.dart';
import 'district_state.dart';


class DistrictBlocNew extends Bloc<DistrictEventNew, DistrictStateNew> {
  ApiService apiService = ApiService();
  GetDistrictResponseModel getDistrictResponseModel =
  GetDistrictResponseModel();
  late CommonResponseModel? commonResponseModel;

  DistrictBlocNew() : super(GetDistrictInitial()) {
    on<GetAllDistrictByState>((event, emit) async {
      try {
        emit(GetDistrictLoading());
        final response = await apiService.newApiCall(
          '/master/district/get_all?stateId=${event.districtRequest["stateId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get District List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getDistrictResponseModel =
                GetDistrictResponseModel.fromJson(responseData);
            emit(GetDistrictSuccess(
                getDistrictResponseModel: getDistrictResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetDistrictFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetDistrictFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetDistrictFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<ClearAllDistrict>((event, emit) {
      emit(GetDistrictInitial());
    });
  }
}
