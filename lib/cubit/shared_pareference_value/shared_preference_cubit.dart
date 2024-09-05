import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/sharepreference_cubit_model.dart';

class AppSharedPreferenceHelperCubit
    extends Cubit<AppSharedPreferenceHelperModel> {
  AppSharedPreferenceHelperCubit() : super(AppSharedPreferenceHelperModel());

  void updateModel({
    String? farmerId,
    String? userId,
    String? token,
    String? incompleteLoanId,
  }) {
    emit(state.copyWith(
        farmerId: farmerId ?? state.farmerId,
        userId: userId ?? state.userId,
        token: token ?? state.token,
        incompleteLoanId: incompleteLoanId ?? state.incompleteLoanId));
  }

  void clearData() {
    emit(AppSharedPreferenceHelperModel()); // Reset state to its initial values
  }
}
