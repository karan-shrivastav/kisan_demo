import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Services/api_service.dart';
import '../../../model/response/common_response_model.dart';
import '../../../model/response/farmer_family_detail_response_model.dart';
import '../../../services/toast_alert.dart';
import '../../../utils/shared_preference_helper.dart';
import 'get_farmer_family_event.dart';
import 'get_farmer_family_state.dart';

class GetFarmerFamilyDetailBloc
    extends Bloc<GetFarmerFamilyDetailEvent, GetFarmerFamilyDetailState> {
  ApiService apiService = ApiService();
  late CommonResponseModel? commonResponseModel;
  GetFarmerFamilyDetailResponseModel getFarmerFamilyDetailResponseModel =
      GetFarmerFamilyDetailResponseModel();

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }

  GetFarmerFamilyDetailBloc()
      : super(GetFarmerFamilyDetailDetailInitial(
            getFarmerFamilyDetailResponseModel:
                GetFarmerFamilyDetailResponseModel())) {
    on<GetFarmerFamilyDetails>((event, emit) async {
      String? farmerId = await getFarmerId();
      try {
        emit(GetFarmerFamilyDetailDetailLoading());
        final response = await apiService.newApiCall(
          '/party/farmer/get_farmer_nominee?farmerId=$farmerId',
        );
        if (kDebugMode) {
          print(("Get Farmer Family Details  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            ToastAlert(responseData["message"]);
            getFarmerFamilyDetailResponseModel =
                GetFarmerFamilyDetailResponseModel.fromJson(responseData);
            emit(GetFarmerFamilyDetailDetailSuccess(
                getFarmerFamilyDetailResponseModel:
                    getFarmerFamilyDetailResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetFarmerFamilyDetailDetailFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetFarmerFamilyDetailDetailFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetFarmerFamilyDetailDetailFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
    on<ClearGetFamilyDetails>((event, emit) {
      getFarmerFamilyDetailResponseModel = GetFarmerFamilyDetailResponseModel();  // Reset to initial state
      emit(GetFarmerFamilyDetailDetailInitial(
          getFarmerFamilyDetailResponseModel:
              GetFarmerFamilyDetailResponseModel()));
    });
  }
}
