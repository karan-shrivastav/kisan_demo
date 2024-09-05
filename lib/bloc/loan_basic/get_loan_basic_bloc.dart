import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/loan_basic_response_model.dart';
import '../../services/toast_alert.dart';
import 'get_loan_basic_event.dart';
import 'get_loan_basic_state.dart';



import 'dart:convert';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_event.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_state.dart';
import 'package:ekisan_credit/model/response/get_farmer_by_id_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../services/toast_alert.dart';
import '../../utils/shared_preference_helper.dart';

class GetLoanBasicBloc
    extends Bloc<GetLoanBasicEvent, GetBasicLoanState>{
  ApiService apiService = ApiService();
  LoanBasicResponseModel getBasicLoanResponseModel = LoanBasicResponseModel();
  late CommonResponseModel? commonResponseModel;



  GetLoanBasicBloc() : super(GetBasicLoanInitial()) {
    on<GetBasicLoanResponse>((event, emit) async {

      try {
        emit(GetBasicLoanLoading());
        final response =
        await apiService.newApiCall('/loan/master/loan_detail?id=${event.loanId}',
           );
        if (kDebugMode) {
          print(("Get Loan Data ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if(responseData['data'] != null){
              getBasicLoanResponseModel =
                  LoanBasicResponseModel.fromJson(responseData);
              emit(GetBasicLoanSuccess(
                 loanBasicResponseModel: getBasicLoanResponseModel));

            }else{
              emit(GetBasicLoanSuccess(
                  loanBasicResponseModel: LoanBasicResponseModel()));
            }

          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetBasicLoanFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        }
        else{
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetBasicLoanFail(
              commonResponseModel:  CommonResponseModel(
                  statusCode: 400, message:  responseData["message"])));
        }
      } catch (err) {
        emit(GetBasicLoanFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    // on<ResetFarmerDetails>((event, emit) {
    //   getFarmerResponseModel = GetFarmerByIdResponseModel();  // Reset to initial state
    //   emit(GetBasicLoanInitial());  // Emit an initial state to refresh UI
    // });
  }

}

//
// class GetLoanBasicBloc extends Bloc<GetLoanBasicEvent, GetBasicLoanState> {
//   ApiService apiService = ApiService();
//   LoanBasicResponseModel getBasicLoanResponseModel = LoanBasicResponseModel();
//   late CommonResponseModel? commonResponseModel;
//
//   GetLoanBasicBloc() : super(GetBasicLoanInitial()) {
//     on<GetBasicLoanResponse>((event, emit) async {
//       try {
//         emit(GetBasicLoanLoading());
//         final response = await apiService.newApiCall(
//           '/loan/master/loan_detail?id=${event.loanId}',
//         );
//         //   final Map<String, dynamic> responseData = json.decode(response.body);
//         if (kDebugMode) {
//           print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22');
//           print(("Get Loan Response:  ${response.body}"));
//           print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22');
//         }
//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           if (responseData['status'] == 200) {
//             getBasicLoanResponseModel =
//                 LoanBasicResponseModel.fromJson(responseData);
//             emit(GetBasicLoanSuccess(
//                 loanBasicResponseModel: getBasicLoanResponseModel));
//           } else {
//             commonResponseModel = const CommonResponseModel(
//                 statusCode: 400, message: 'Something went wrong');
//             emit(GetBasicLoanFail(
//                 commonResponseModel: const CommonResponseModel(
//                     statusCode: 400, message: 'Something went wrong')));
//           }
//         }
//         else{
//           final Map<String, dynamic> responseData = json.decode(response.body);
//           ToastAlert(responseData["message"]);
//           emit(GetBasicLoanFail(
//               commonResponseModel:  CommonResponseModel(
//                   statusCode: 400, message:  responseData["message"])));
//         }
//       } catch (err) {
//         emit(GetBasicLoanFail(
//             commonResponseModel: const CommonResponseModel(
//                 statusCode: 400, message: 'Something went wrong')));
//         if (kDebugMode) {
//           print(err);
//         }
//       }
//     });
//   }
// }
