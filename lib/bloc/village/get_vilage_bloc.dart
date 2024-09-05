import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_village_response_model.dart';
import '../../services/toast_alert.dart';
import 'get_village_event.dart';
import 'get_village_state.dart';

class GetVillageNewBloc
    extends Bloc<GetVillageDataNewListEvent, GetVillageDataNewState> {


  ApiService apiService = ApiService();
  GetVillageResponseModel getVillageResponseModel = GetVillageResponseModel();
  late CommonResponseModel? commonResponseModel;

  GetVillageNewBloc() : super(GetVillageInitial()) {
    on<GetAllVillageByDistrict>((event, emit) async {
      try {
        emit(GetVillageLoading());
        final response = await apiService.newApiCallTypePost(
          '/master/village/get_all?districtId=${event.villageRequest["districtId"]}',
          body: event.villageRequest
        );
        if (kDebugMode) {
          print(("Get Village List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getVillageResponseModel =
                GetVillageResponseModel.fromJson(responseData);
            emit(
              GetVillageSuccess(
                getVillageResponseModel: getVillageResponseModel,
              ),
            );
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(
              GetVillageFail(
                commonResponseModel: const CommonResponseModel(
                  statusCode: 400,
                  message: 'Something went wrong',
                ),
              ),
            );
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetVillageFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(
          GetVillageFail(
            commonResponseModel: const CommonResponseModel(
              statusCode: 400,
              message: 'Something went wrong',
            ),
          ),
        );
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
