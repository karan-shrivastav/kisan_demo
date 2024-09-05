import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/foundation.dart';

import '../../Services/api_service.dart';
import '../../model/response/bank_list_response_model.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import 'bank_list_new.dart';
import 'bank_list_state.dart';

class GetBankListNewBloc extends Bloc<BankListNewEvent, BankListNewState> {
  ApiService apiService = ApiService();
  late CommonResponseModel? commonResponseModel;
  BankListResponseModel bankListResponseModel = BankListResponseModel();

  GetBankListNewBloc() : super(GetBankListNewInitial()) {
    on<GetBanNewBankList>((event, emit) async {
      try {
        emit(GetBankListNewLoading());
        final response = await apiService.newApiCall(
          '/master/banks/bank_list_v3?type=${event.bankRequest["type"]}&stateId=${event.bankRequest["stateId"]}&districtId=${event.bankRequest["districtId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get BankList  response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            bankListResponseModel =
                BankListResponseModel.fromJson(responseData);
            emit(GetBankListNewSuccess(
                bankListResponseModel: bankListResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetBankListNewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetBankListNewFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetBankListNewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
