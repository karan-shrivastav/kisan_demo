import 'dart:convert';
import 'package:ekisan_credit/bloc/selected_land_details/selected_land_details_event.dart';
import 'package:ekisan_credit/bloc/selected_land_details/selected_land_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/api_service.dart';
import 'package:flutter/foundation.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/selected_land_details_response_model.dart';
import '../../services/toast_alert.dart';

class SelectedLandBloc
    extends Bloc<SelectedLandDetailsEvent, SelectedLandDetailsState> {
  ApiService apiService = ApiService();
  SelectedLandDetailsResponseModel selectedLandDetailsResponseModel =
  SelectedLandDetailsResponseModel();
  late CommonResponseModel? commonResponseModel;

  SelectedLandBloc() : super(SelectedLandDetailsInitial()) {
    on<GetSelectedLandDetails>((event, emit) async {
      try {
        emit(SelectedLandDetailsLoading());
        final response = await apiService.newApiCall(
          '/loan/master/land_detail?id=${event.loanId}',
        );
        if (kDebugMode) {
          print('_____________________________________________________2');
          print(("Get Selected Land Response Data : ${response.body}"));
          print('_____________________________________________________2');
        }
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          if (responseData['status'] == 200) {
            if (responseData['data'] != null) {
              selectedLandDetailsResponseModel =
                  SelectedLandDetailsResponseModel.fromJson(responseData);
              emit(SelectedLandDetailsSuccess(
                  selectedLandDetailsResponseModel: selectedLandDetailsResponseModel));
            } else {
              emit(SelectedLandDetailsSuccess(
                  selectedLandDetailsResponseModel: SelectedLandDetailsResponseModel()));
            }
          } else {
            commonResponseModel = const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong');
            emit(SelectedLandDetailsFail(
                commonResponseModel: const CommonResponseModel(
                    statusCode: 400, message: 'Something went wrong')));
          }
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          ToastAlert(responseData["message"]);
          emit(SelectedLandDetailsFail(
              commonResponseModel: CommonResponseModel(
                  statusCode: 400, message: responseData["message"])));
        }
      } catch (err) {
        emit(SelectedLandDetailsFail(
            commonResponseModel: const CommonResponseModel(
                statusCode: 400, message: 'Something went wrong')));
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }
}
