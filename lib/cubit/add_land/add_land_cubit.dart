import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/add_land_cubit_model.dart';

class AddLandCubit extends Cubit<AddLandCubitModel> {
  AddLandCubit() : super(AddLandCubitModel());

  void updateModel({
    int? farmerId,
    int? stateMasterId,
    int? districtMasterId,
    int? villageId,
    int? ownershipId,
    int? areaUnitId,
    int? sourceOfIrrigationId,
    String? surveyNo,
    String? encumbered,
    String? area,
    String? irrigatedLand,
    int? unIrrigatedLand,
  }) {
    emit(state.copyWith(
        farmerId: farmerId ?? state.farmerId,
        stateMasterId: stateMasterId ?? state.stateMasterId,
        districtMasterId: districtMasterId ?? state.districtMasterId,
        villageId: villageId ?? state.villageId,
        ownershipId: ownershipId ?? state.ownershipId,
        areaUnitId: areaUnitId ?? state.areaUnitId,
        sourceOfIrrigationId:
            sourceOfIrrigationId ?? state.sourceOfIrrigationId,
        surveyNo: surveyNo ?? state.surveyNo,
        encumbered: encumbered ?? state.encumbered,
        area: area ?? state.area,
        irrigatedLand: area ?? state.area,
        unIrrigatedLand: unIrrigatedLand ?? state.unIrrigatedLand));
  }

  void clearData() {
    emit(AddLandCubitModel()); // Reset state to its initial values
  }
}
