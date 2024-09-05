import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/get_all_bank_type_response_model.dart';
import '../../services/toast_alert.dart';
import 'bank_type_event.dart';
import 'bank_type_state.dart';

class BankTypeNewBloc extends Bloc<BankTypeEvent, BankTypeNewState> {
  ApiService apiService = ApiService();
  GetAllBankTypeResponseModel getAllBankTypeResponseModel =
      GetAllBankTypeResponseModel();
  late CommonResponseModel? commonResponseModel;

  BankTypeNewBloc() : super(GetBankTypeInitial()) {
    on<GetALlBankTypeData>((event, emit) async {
      try {
        emit(GetBankTypeLoading());
        final response = await apiService.newApiCall(
          '/master/banks/bank_type?type=bank',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get BankType  List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getAllBankTypeResponseModel =
                GetAllBankTypeResponseModel.fromJson(responseData);
            emit(GetBankTypeSuccess(
                getAllBankTypeResponseModel: getAllBankTypeResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetBankTypeFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetBankTypeFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetBankTypeFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
