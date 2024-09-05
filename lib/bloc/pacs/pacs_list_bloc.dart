import 'dart:convert';

import 'package:ekisan_credit/bloc/pacs/pacs_list_event.dart';
import 'package:ekisan_credit/bloc/pacs/pacs_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_pacs_list_response_model.dart';
import '../../services/toast_alert.dart';


class PacsListNewBloc extends Bloc<PacsListNewEvent, PacsListNewState> {
  ApiService apiService = ApiService();
  PacsListNewResponseModel pacsListNewResponseModel =
  PacsListNewResponseModel();
  late CommonResponseModel? commonResponseModel;

  PacsListNewBloc() : super(GetPacsListNewInitial()) {
    on<GetPacsListNew>((event, emit) async {
      try {
        emit(GetPacsListNewLoading());
        final response = await apiService.newApiCall(
            '/master/pacs/get_by_branch_id?entityLevelId=${event.branchListRequest["entityLevelId"]}'
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get New Branch List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            pacsListNewResponseModel =
                PacsListNewResponseModel.fromJson(responseData);
            emit(GetPacsListNewSuccess(
                pacsListNewResponseModel: pacsListNewResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetPacsListNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetPacsListNewFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetPacsListNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
