import 'dart:convert';
import 'package:ekisan_credit/bloc/selected_joint_applicant/selected_joint_applicant_event.dart';
import 'package:ekisan_credit/bloc/selected_joint_applicant/selected_joint_applicant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/selected_joint_applicant_response_model.dart';
import '../../services/toast_alert.dart';

class SelectedJointApplicantBloc
    extends Bloc<SelectedJointApplicantEvent, SelectedJointApplicantState> {
  ApiService apiService = ApiService();
  SelectedJointApplicantResponseModel selectedJointApplicantResponseModel =
  SelectedJointApplicantResponseModel();
  late CommonResponseModel? commonResponseModel;

  SelectedJointApplicantBloc() : super(SelectedJointApplicantInitial()) {
    on<GetSelectedApplicantDetails>((event, emit) async {
      try {
        emit(SelectedJointApplicantLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loan_request?id=${event.loanId}',
        );
        if (kDebugMode) {
          print(("Get Selected Joint Applicant Data : ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data'] != null) {
              selectedJointApplicantResponseModel =
                  SelectedJointApplicantResponseModel.fromJson(responseData);

              emit(SelectedJointApplicantSuccess(
                  selectedJointApplicantResponseModel: selectedJointApplicantResponseModel));
            } else {
              emit(SelectedJointApplicantSuccess(
                  selectedJointApplicantResponseModel: SelectedJointApplicantResponseModel()));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SelectedJointApplicantFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SelectedJointApplicantFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(SelectedJointApplicantFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
