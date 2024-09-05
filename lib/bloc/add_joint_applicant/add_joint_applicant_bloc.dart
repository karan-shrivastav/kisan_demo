import 'dart:convert';
import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_event.dart';
import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/add_joint_applicant_response_model.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';

class AddJointApplicantBloc
    extends Bloc<AddJointApplicantEvent, AddJointApplicantState> {
  ApiService apiService = ApiService();
  AddJointApplicantResponseModel addJointApplicantResponseModel =
      AddJointApplicantResponseModel();
  late CommonResponseModel? commonResponseModel;

  AddJointApplicantBloc() : super(AddJointApplicantInitial()) {
    on<AddJointApplicantDetails>((event, emit) async {
      try {
        emit(AddJointApplicantLoading());
        final response = await apiService.newApiCallTypePost(
            '/party/joint_applicant/save',
            body: event.body);
        if (kDebugMode) {
          print(("Joint applicant Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            ToastAlert(responseData["message"]);
            addJointApplicantResponseModel =
                AddJointApplicantResponseModel.fromJson(responseData);
            emit(AddJointApplicantSuccess(
                addJointApplicantResponseModel:
                    addJointApplicantResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(AddJointApplicantFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(AddJointApplicantFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(AddJointApplicantFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
