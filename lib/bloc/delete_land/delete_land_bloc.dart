import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/delete_land_response.dart';
import '../../services/toast_alert.dart';
import 'delete_land_data_event.dart';
import 'delete_land_data_state.dart';

class DeleteLandDataBloc
    extends Bloc<DeleteLandDataEvent, DeleteLandDataState> {
  ApiService apiService = ApiService();
  DeleteLandResponse deleteLandResponseModel = DeleteLandResponse();
  late CommonResponseModel? commonResponseModel;

  DeleteLandDataBloc() : super(DeleteDataInitial()) {
    on<DeleteLandData>((event, emit) async {
      try {
        emit(DeleteLandDataLoading());
        final response = await apiService.deleteApiCallById(
          '/party/land_details/${event.id}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Delete land   ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            deleteLandResponseModel = DeleteLandResponse.fromJson(responseData);
            ToastAlert(responseData["message"]);
            emit(DeleteLandDataSuccess(
                deleteLandResponseModel: deleteLandResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(DeleteLandDataFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(DeleteLandDataFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(DeleteLandDataFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
