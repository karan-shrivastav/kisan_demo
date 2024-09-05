import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/delete_joint_applicant_response_model.dart';
import '../../services/toast_alert.dart';
import 'delete_joint_applicant_event.dart';
import 'delete_joint_applicant_state.dart';

class DeleteJointApplicantBloc extends Bloc<DeleteJointApplicantEvent, DeleteJointApplicantState> {
  ApiService apiService = ApiService();
  DeleteJointApplicantResponseModel deleteJointApplicantResponseModel =
  DeleteJointApplicantResponseModel();

  late CommonResponseModel? commonResponseModel;

  DeleteJointApplicantBloc() : super(DeleteJointApplicantInitial()) {
    on<DeleteJointApplicant>((event, emit) async {
      try {
        emit(DeleteJointApplicantLoading());
        final response = await apiService.deleteApiCallById(
          '/party/joint_applicant?joinApplicationId=${event.id}',
        );
        if (kDebugMode) {
          print(("Get LovsType Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            ToastAlert(responseData["message"]);
            deleteJointApplicantResponseModel =
                DeleteJointApplicantResponseModel.fromJson(responseData);
            emit(DeleteJointApplicantSuccess(
                deleteJointApplicantResponseModel: deleteJointApplicantResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(DeleteJointApplicantFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(DeleteJointApplicantFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(DeleteJointApplicantFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
