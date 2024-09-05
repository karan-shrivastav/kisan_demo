import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_branch_list_response_model.dart';
import '../../services/toast_alert.dart';
import 'branch_list_event.dart';
import 'branch_list_state.dart';

class BranchListNewBloc extends Bloc<BranchListNewEvent, BranchListNewState> {
  ApiService apiService = ApiService();
  BranchListResponseModel branchListResponseModel = BranchListResponseModel();
  late CommonResponseModel? commonResponseModel;

  BranchListNewBloc() : super(GetNewBranchListInitial()) {
    on<GetNewBranchList>((event, emit) async {
      try {
        emit(GetNewBranchListLoading());
        final response = await apiService.newApiCall(
          '/master/entity_levels/get_branch?stateId=${event.branchListRequest["stateId"]}&districtId=${event.branchListRequest["districtId"]}&bankMasterId=${event.branchListRequest["bankMasterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get New Branch List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            branchListResponseModel =
                BranchListResponseModel.fromJson(responseData);
            emit(GetNewBranchListSuccess(
                branchListResponseModel: branchListResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetNewBranchListFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetNewBranchListFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetNewBranchListFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
