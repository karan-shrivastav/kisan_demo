import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/delete_family_response_model.dart';
import '../../services/toast_alert.dart';
import 'delete_family_event.dart';
import 'delete_family_state.dart';

class DeleteFamilyBloc extends Bloc<DeleteFamilyEvent, DeleteFamilyState> {
  ApiService apiService = ApiService();
  DeleteFamilyReponseModel deleteFamilyResponseModel =
      DeleteFamilyReponseModel();

  late CommonResponseModel? commonResponseModel;

  DeleteFamilyBloc() : super(DeleteFamilyInitial()) {
    on<DeleteFamilyInfoDetails>((event, emit) async {
      try {
        emit(DeleteFamilyLoading());
        final response = await apiService.deleteApiCallById(
          '/party/farmer_nominee?nomineeId=${event.id}',
        );
        if (kDebugMode) {
          print(("Get farmer Nominee ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            ToastAlert(responseData["message"]);
            deleteFamilyResponseModel =
                DeleteFamilyReponseModel.fromJson(responseData);
            emit(DeleteFamilySuccess(
                deleteFamilyResponseModel: deleteFamilyResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(DeleteFamilyFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(DeleteFamilyFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(DeleteFamilyFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
