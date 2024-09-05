import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_assets_response_model.dart';
import '../../services/toast_alert.dart';
import 'loan_assets_event.dart';
import 'loan_assets_state.dart';

class LoanAssetsBloc extends Bloc<LoanAssetsEvent, LoanAssetsState> {
  ApiService apiService = ApiService();
  LoanAssetsResponseModel loanAssetsResponseModel = LoanAssetsResponseModel();
  late CommonResponseModel? commonResponseModel;

  LoanAssetsBloc() : super(LoanAssetsInitial()) {
    on<GetLoanAssetsDetails>((event, emit) async {
      try {
        emit(LoanAssetsLoading());
        final response = await apiService.newApiCall(
          '/loan/master/loan_assest?id=${event.loanId}',
        );
        if (kDebugMode) {
          print('________________________________________________8');
          print(("Get Assets Data : ${response.body}"));
          print('________________________________________________8');
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['dataList'] != null) {
              loanAssetsResponseModel =
                  LoanAssetsResponseModel.fromJson(responseData);

              emit(LoanAssetsSuccess(
                  loanAssetsResponseModel: loanAssetsResponseModel));
            } else {
              emit(LoanAssetsSuccess(
                  loanAssetsResponseModel: loanAssetsResponseModel));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(LoanAssetsFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(LoanAssetsFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(LoanAssetsFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
