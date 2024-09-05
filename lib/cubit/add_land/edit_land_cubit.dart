import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/edit_land_cubit_model.dart';

class EditLandCubit extends Cubit<EditLandCubitModel> {
  EditLandCubit() : super(EditLandCubitModel());

  void updateModel({
    int? id,
    int? farmerId,
    int? stateMasterId,
    String? stateName,
    int? districtMasterId,
    String? districtName,
    int? villageId,
    String? villageName,
    int? ownershipId,
    String? ownerShipName,
    int? areaUnitId,
    String? areaUnitName,
    int? sourceOfIrrigationId,
    String? sourceOfIrrigationNAme,
    String? surveyNo,
    String? encumbered,
    dynamic area,
    dynamic irrigatedLand,
    dynamic unIrrigatedLand,
  }) {
    emit(state.copyWith(
      id: id ?? state.id,
        farmerId: farmerId ?? state.farmerId,
        stateMasterId: stateMasterId ?? state.stateMasterId,
        stateName:stateName ?? state.stateName,
        districtMasterId: districtMasterId ?? state.districtMasterId,
        districtName: districtName ?? state.districtName,
        villageId: villageId ?? state.villageId,
        villageName: villageName ?? state.villageName,
        ownershipId: ownershipId ?? state.ownershipId,
        ownerShipName: ownerShipName ?? state.ownerShipName,
        areaUnitId: areaUnitId ?? state.areaUnitId,
        areaUnitName: areaUnitName ?? state.areaUnitName,
        sourceOfIrrigationId:
            sourceOfIrrigationId ?? state.sourceOfIrrigationId,
        sourceOfIrrigationNAme: sourceOfIrrigationNAme ?? state.sourceOfIrrigationNAme,
        surveyNo: surveyNo ?? state.surveyNo,
        encumbered: encumbered ?? state.encumbered,
        area: area ?? state.area,
        irrigatedLand: area ?? state.area,
        unIrrigatedLand: unIrrigatedLand ?? state.unIrrigatedLand));
  }

  void calculateLandByUnitNew() {

    print(state.area);
    if (state.area!.isNotEmpty) {


      if (state.areaUnitId == 870) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            unIrrigatedLand: (int.parse(state.area ?? '0') / 100).toStringAsFixed(3),
            irrigatedLand: '0',
          );
        } else {
          updateModel(
            unIrrigatedLand: '0',
            irrigatedLand: (int.parse(state.area ?? '0') / 100).toStringAsFixed(3),
          );
        }
      } else if (state.areaUnitId == 411) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            unIrrigatedLand: (int.parse(state.area ?? '0') / 40).toStringAsFixed(3),
            irrigatedLand: "0",
          );
        } else {
          updateModel(
            unIrrigatedLand: "0",
            irrigatedLand: (int.parse(state.area ?? '0') / 40).toStringAsFixed(3),
          );
        }
      } else if (state.areaUnitId == 410) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            unIrrigatedLand: state.area,
            irrigatedLand: "0",
          );
        } else {
          updateModel(
            unIrrigatedLand: "0",
            irrigatedLand: state.area,
          );
        }
      } else if (state.areaUnitId == 408) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            unIrrigatedLand: (int.parse(state.area ?? '0') / 0.4046856422).toStringAsFixed(3),
            irrigatedLand: "0",
          );
        } else {
          updateModel(
            unIrrigatedLand: (int.parse(state.area ?? '0') / 0.4046856422).toStringAsFixed(3),
            irrigatedLand: "0",
          );
        }
      } else {
        updateModel(
          irrigatedLand: "0",
        );
      }
    }
  }
}
