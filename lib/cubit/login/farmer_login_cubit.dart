

import 'package:ekisan_credit/cubit/model/farmer_info_model_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmerInfoCubit extends Cubit<FarmerInfoModelCubit> {
  FarmerInfoCubit() : super(FarmerInfoModelCubit());

  void updateModel({
    String? mobileNumber,
    String ? captcha,
    String ? fromScreen

  }) {
    emit(state.copyWith(
        mobileNumber: mobileNumber ?? state.mobileNumber,
      captcha: captcha ?? state.captcha,
      fromScreen: fromScreen ?? state.fromScreen


    ));
  }
  void clear() {
    emit(FarmerInfoModelCubit());
  }
}