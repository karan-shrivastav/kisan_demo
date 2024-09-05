import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';

import '../../Utils/shared_preference_helper.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/land_details_response_model.dart';
import '../../services/toast_alert.dart';
import 'get_land_details_event.dart';
import 'get_land_details_state.dart';

class GetLandDataBloc extends Bloc<GetLandDataEvent, GetLandDataState> {
  ApiService apiService = ApiService();

  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }

  GetLandDetailsResponseModel getLandResponseModel =
      GetLandDetailsResponseModel();
  late CommonResponseModel? commonResponseModel;

  GetLandDataBloc() : super(GetLandDataInitial()) {
    on<GetLandListData>((event, emit) async {
      try {
        final farmerId = await loadData();
        emit(GetLandDataLoading());
        final response = await apiService.newApiCallTypePost(
            '/party/land_details/get_by/$farmerId?order=asc&size=10&page=0',

            body: event.landRequest);
        if (kDebugMode) {
          print(("Get Land Name List response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            getLandResponseModel =
                GetLandDetailsResponseModel.fromJson(responseData);
            emit(
                GetLandDataSuccess(getLandResponseModel: getLandResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(GetLandDataFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(GetLandDataFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(GetLandDataFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
