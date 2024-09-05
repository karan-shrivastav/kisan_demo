import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';

import '../../../Services/api_service.dart';
import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_preview_joint_applicant_response_model.dart';
import '../../../services/toast_alert.dart';
import 'loan_preview_joint_applicant_event.dart';
import 'loan_preview_joint_applicant_state.dart';

class PreviewBasicsDetailsBloc
    extends Bloc<PreviewBasicsDetailsEvent, PreviewBasicsDetailsState> {
  ApiService apiService = ApiService();
  BasicDetailsNewResponseModel basicDetailsNewResponseModel =
      BasicDetailsNewResponseModel();
  late CommonResponseModel? commonResponseModel;

  PreviewBasicsDetailsBloc() : super(PreviewBasicsDetailsInitial()) {
    on<GetPreviewBasicsDetails>((event, emit) async {
      if (kDebugMode) {
        print(
            "Api calling for basic details joint Applicant _  /loan/master/loan_request?id?id=${event.bodyRequest["masterId"]}}");
      }
      try {
        emit(PreviewBasicsDetailsLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loan_request?id=${event.bodyRequest["masterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(
              ("Get Loanof basics details   joint Applicant --response  ${response.body}"));
          print(response.statusCode);
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            basicDetailsNewResponseModel =
                BasicDetailsNewResponseModel.fromJson(responseData);
            emit(PreviewBasicsDetailSuccess(
                basicDetailsNewResponseModel: basicDetailsNewResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(PreviewBasicsDetailFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(PreviewBasicsDetailFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(PreviewBasicsDetailFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
