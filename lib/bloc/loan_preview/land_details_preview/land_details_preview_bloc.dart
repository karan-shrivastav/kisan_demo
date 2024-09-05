import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart';

import '../../../Services/api_service.dart';
import '../../../model/response/common_response_model.dart';
import '../../../model/response/land_details_preview_response_model.dart';
import '../../../services/toast_alert.dart';
import 'land_details_preview_event.dart';
import 'land_details_preview_state.dart';

class LandDetailsNewPreviewBloc
    extends Bloc<LandDetailsNewPreviewEvent, LandDetailsNewPreviewState> {
  ApiService apiService = ApiService();
  LandDetailsNewPreviewResponseModel landDetailsNewPreviewResponseModel =
      LandDetailsNewPreviewResponseModel();
  late CommonResponseModel? commonResponseModel;

  LandDetailsNewPreviewBloc() : super(LandDetailsNewPreviewInitial()) {
    on<GetLandNewDetailsForPreview>((event, emit) async {
      if (kDebugMode) {
        print(
            "Api calling for land details /loan/master/land_detail?id=${event.bodyRequest["masterId"]}}");
      }
      try {
        emit(LandDetailsNewPreviewLoading());
        final response = await apiService.newApiCall(
          '/loan/master/land_detail?id=${event.bodyRequest["masterId"]}',
        );
        //   final Map<String, dynamic> responseData = json.decode(response.body);
        if (kDebugMode) {
          print(("Get Land  details --response  ${response.body}"));
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            landDetailsNewPreviewResponseModel =
                LandDetailsNewPreviewResponseModel.fromJson(responseData);
            emit(LandDetailsNewPreviewSuccess(
                landDetailsNewPreviewResponseModel:
                    landDetailsNewPreviewResponseModel));
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(LandDetailsNewPreviewFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(LandDetailsNewPreviewFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(LandDetailsNewPreviewFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
