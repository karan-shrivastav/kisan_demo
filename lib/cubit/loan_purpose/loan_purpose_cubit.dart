import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/laon_purpose_cubit_model.dart';

class LoanPurposeCubit extends Cubit<LoanPurposeCubitModel> {
  LoanPurposeCubit() : super(LoanPurposeCubitModel());

  void updateModel({
    String? firstAmount,
    String? secondAmount,
    String? thirdAmount,
    dynamic masterId,
    String? totalLandArea,
    String? otherDescription,
    bool? agriculture,
    bool? other,
    String ?  totalLandAreaUnitId,
  }) {
    emit(state.copyWith(
        firstAmount: firstAmount ?? state.firstAmount,
        secondAmount: secondAmount ?? state.secondAmount,
        thirdAmount: thirdAmount ?? state.thirdAmount,
        masterId: masterId ?? state.masterId,
        totalLandArea: totalLandArea ?? state.totalLandArea,
        otherDescription: otherDescription ?? state.otherDescription,
        agriculture: agriculture ?? state.agriculture,
        other: other ?? state.other,
      totalLandAreaUnitId: totalLandAreaUnitId ?? state.totalLandAreaUnitId
    ));
  }

  void clear() {
    emit(LoanPurposeCubitModel());
  }
}
