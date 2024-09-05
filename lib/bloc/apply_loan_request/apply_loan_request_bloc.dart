import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';

import '../../model/response/apply_loan_request_response_model.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import 'apply_laon_request_event.dart';
import 'apply_loan_request_state.dart';
import 'package:flutter/foundation.dart';

class ApplyLoanRequestBloc
    extends Bloc<ApplyLoanRequestEvent, ApplyLoanRequestState> {
  ApiService apiService = ApiService();
  ApplyLoanRequestResponseModel applyLoanRequestResponseModel =
      ApplyLoanRequestResponseModel();
  late CommonResponseModel? commonResponseModel;

  ApplyLoanRequestBloc() : super(ApplyLoanRequestInitial()) {
    on<ApplyLoanRequest>((event, emit) async {
      try {
        if (kDebugMode) {
          print(event.requestBody);
        }
        emit(ApplyLoanRequestLoading());
        final response = await apiService.newApiCallTypePost(
            '/loan/master/save_loan_request/${event.requestBody["masterId"]}',
            body: event.requestBody);
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Apply loan request model  ${response.body}"));
        }

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          if (responseData['status'] == 200) {
            applyLoanRequestResponseModel =
                ApplyLoanRequestResponseModel.fromJson(responseData);
            emit(ApplyLoanRequestSuccess(
                applyLoanRequestResponseModel: applyLoanRequestResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(ApplyLoanRequestFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(ApplyLoanRequestFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(ApplyLoanRequestFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
