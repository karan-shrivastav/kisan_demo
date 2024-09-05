import 'dart:convert';

import 'package:ekisan_credit/bloc/relationships/relationship_data_event.dart';
import 'package:ekisan_credit/bloc/relationships/relationship_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/relationship_response_model.dart';
import '../../services/toast_alert.dart';



class RelationshipDataBloc
    extends Bloc<RelationshipDataEvent, RelationshipDataState> {
  ApiService apiService = ApiService();
  RelationshipDataModel getRelationshipResponseModel =
  RelationshipDataModel();
  late CommonResponseModel? commonResponseModel;

  RelationshipDataBloc() : super(GetRelationshipInitial()) {
    on<GetRelationshipList>((event, emit) async {
      try {
        emit(GetRelationshipLoading());
        final response =
        await apiService.apiCallTypeList('/master/lovs/lov_relation',
            body: event.bodyRequest);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get Relationship Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getRelationshipResponseModel =
                RelationshipDataModel.fromJson(responseData);
            emit(GetRealationshipSuccess(
                getRealtionshipResponseModel:
                getRelationshipResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetRealtioanshipFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetRealtioanshipFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetRealtioanshipFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
