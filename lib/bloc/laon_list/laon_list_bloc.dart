import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../Services/api_service.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_list_response_model.dart';
import 'loan_list_event.dart';
import 'loan_list_state.dart';

class LoanListBloc extends Bloc<LoanListEvent, LoanListStateData> {
  ApiService apiService = ApiService();
  GetLoanListResponseModel getLoanListResponseModel =
      GetLoanListResponseModel();
  late CommonResponseModel? commonResponseModel;

  LoanListBloc() : super(GetLoanListInitial()) {
    on<GetLoanList>((event, emit) async {
      try {
        emit(GetLoanListLoading());
        final response = await apiService.newApiCallTypePost('/loan/master/get_all_loan?page=0&size=25&order=desc&sort=createdDate',
            body: event.loanListRequest);

        if (kDebugMode) {
          print(("Get Loan List response  ${response.body}"));
        }

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getLoanListResponseModel =
                GetLoanListResponseModel.fromJson(responseData);

            // Sort the list by moving incomplete items to the front
            getLoanListResponseModel.data!.content!.sort((a, b) {
              if (a.status == 'Incomplete' && b.status != 'Incomplete') {
                return -1;
              } else if (a.status != 'Incomplete' && b.status == 'Incomplete') {
                return 1;
              } else {
                return 0;
              }
            });

            emit(GetLoanListSuccess(
                getLoanListResponseModel: getLoanListResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetLoanListFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
      } catch (err) {
        emit(GetLoanListFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));

        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
