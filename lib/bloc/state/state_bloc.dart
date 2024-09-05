import 'dart:convert';

import 'package:ekisan_credit/bloc/state/state_event.dart';
import 'package:ekisan_credit/bloc/state/state_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_all_state_response_model.dart';
import '../../services/toast_alert.dart';


class StateBloc extends Bloc<StateEventNew,StateState>{
  ApiService apiService = ApiService();
  GetAllStateResponseModel getAllStateResponseModel  = GetAllStateResponseModel();
  late CommonResponseModel? commonResponseModel;
  StateBloc():super(GetStateInitial()){
    on<GetAllState>((event, emit) async {
      emit(GetStateLoading());
      try {
        final response = await apiService.newApiCall('/master/state/get_all',

        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get State List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getAllStateResponseModel =
                GetAllStateResponseModel.fromJson(responseData);
            emit(GetStateSuccess(
                getAllStateResponseModel: getAllStateResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetStateFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetStateFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetStateFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<ClearAllState>((event,emit){
      emit(GetStateInitial());

    });

  }
}