import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../Services/api_service.dart';
import '../../../model/response/common_response_model.dart';
import '../../../model/response/loan_asset_preview_response_model.dart';
import '../../../services/toast_alert.dart';
import 'laon_asset_preview_event.dart';
import 'loan_asset_preview_state.dart';

class LoanAssetPreviewNewBloc
    extends Bloc<LoanAssetPreviewNewEvent, LoanAssetPreviewNewState> {
  ApiService apiService = ApiService();
  GetLoanAssetNewPreviewResponseModel getLoanAssetNewPreviewResponseModel =
      GetLoanAssetNewPreviewResponseModel();
  late CommonResponseModel? commonResponseModel;

  LoanAssetPreviewNewBloc() : super(LoanAssetPreviewNewInitial()) {
    on<GetAssetNewPreview>((event, emit) async {
      try {
        emit(LoanAssetPreviewNewLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loan_assest?id=${event.bodyRequest["masterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(
              ("Get LoanAssetPreview Data   List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getLoanAssetNewPreviewResponseModel =
                GetLoanAssetNewPreviewResponseModel.fromJson(responseData);
            emit(LoanAssetPreviewNewSuccess(
                getLoanAssetNewPreviewResponseModel:
                    getLoanAssetNewPreviewResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(LoanAssetPreviewNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(LoanAssetPreviewNewFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(LoanAssetPreviewNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
