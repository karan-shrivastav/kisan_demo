import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_bank_type_type_response_model.dart';
import '../../services/toast_alert.dart';
import 'banks_bank_by_type_event.dart';
import 'banks_bank_by_type_state.dart';
import 'package:flutter/foundation.dart';

class BanksNewBankByTypeBloc
    extends Bloc<BanksNewBankByTypeEvent, BanksNewBankByTypeState> {
  ApiService apiService = ApiService();
  late CommonResponseModel? commonResponseModel;
  GetBanksTypeTypeResponseModel getBanksTypeTypeResponseModel =
      GetBanksTypeTypeResponseModel();

  BanksNewBankByTypeBloc() : super(BanksNewBankByTypeInitial()) {
    on<GetNewBanksBankByType>((event, emit) async {
      try {
        emit(BanksNewBankByTypeLoading());
        final response = await apiService.newApiCall(
          '/master/banks/bank_by_type?type=${event.bankRequest["type"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get BankListBy Bak Typeresponse  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getBanksTypeTypeResponseModel =
                GetBanksTypeTypeResponseModel.fromJson(responseData);
            emit(BanksNewBankByTypeSuccess(
                getBanksTypeTypeResponseModel: getBanksTypeTypeResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(BanksNewBankByTypeFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(BanksNewBankByTypeFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(BanksNewBankByTypeFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
