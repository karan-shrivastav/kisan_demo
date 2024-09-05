import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/add_land_irrigated_non_irrigated_cubit_model.dart';

class AddLandIrrigatedNonIrrigatedCubit
    extends Cubit<AddLandIrrigatedNonIrrigatedCubitModel> {
  AddLandIrrigatedNonIrrigatedCubit()
      : super(AddLandIrrigatedNonIrrigatedCubitModel());

  void updateModel(
      {String? irrigated,
      String? nonIrrigated,
      String? landSize,
      int? areaUnitId,
      int? sourceOfIrrigationId}) {
    emit(state.copyWith(
        irrigated: irrigated ?? state.irrigated,
        nonIrrigated: nonIrrigated ?? state.nonIrrigated,
        landSize: landSize ?? state.landSize,
        areaUnitId: areaUnitId ?? state.areaUnitId,
        sourceOfIrrigationId:
            sourceOfIrrigationId ?? state.sourceOfIrrigationId));
  }

  void calculateLandByUnitNew() {
    print(state.landSize);
    if (state.landSize!.isNotEmpty) {
      if (state.areaUnitId == 870) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated:
                (int.parse(state.landSize ?? '0') / 100).toStringAsFixed(3),
            irrigated: '0',
          );
        } else {
          updateModel(
            nonIrrigated: '0',
            irrigated:
                (int.parse(state.landSize ?? '0') / 100).toStringAsFixed(3),
          );
        }
      } else if (state.areaUnitId == 411) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated:
                (int.parse(state.landSize ?? '0') / 40).toStringAsFixed(3),
            irrigated: "0",
          );
        } else {
          updateModel(
            nonIrrigated: "0",
            irrigated:
                (int.parse(state.landSize ?? '0') / 40).toStringAsFixed(3),
          );
        }
      } else if (state.areaUnitId == 410) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated: state.landSize,
            irrigated: "0",
          );
        } else {
          updateModel(
            nonIrrigated: "0",
            irrigated: state.landSize,
          );
        }
      } else if (state.areaUnitId == 408) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated: (int.parse(state.landSize ?? '0') / 0.4046856422)
                .toStringAsFixed(3),
            irrigated: "0",
          );
        } else {
          updateModel(
            irrigated: (int.parse(state.landSize ?? '0') / 0.4046856422)
                .toStringAsFixed(3),
            nonIrrigated: "0",
          );
        }
      } else {
        updateModel(
          irrigated: "0",
        );
      }
    }
  }

  void calculateLandByUnitNewData(landSize) {
    if (state.landSize!.isNotEmpty) {
      if (state.areaUnitId == 870) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated: (int.parse(landSize ?? '0') / 100).toStringAsFixed(3),
            irrigated: '0',
          );
        } else {
          updateModel(
            nonIrrigated: '0',
            irrigated: (int.parse(landSize ?? '0') / 100).toStringAsFixed(3),
          );
        }
      } else if (state.areaUnitId == 411) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated:
                (int.parse(state.landSize ?? '0') / 40).toStringAsFixed(3),
            irrigated: "0",
          );
        } else {
          updateModel(
            nonIrrigated: "0",
            irrigated: (int.parse(landSize ?? '0') / 40).toStringAsFixed(3),
          );
        }
      } else if (state.areaUnitId == 410) {
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated: landSize,
            irrigated: "0",
          );
        } else {
          updateModel(
            nonIrrigated: "0",
            irrigated: landSize,
          );
        }
      } else if (state.areaUnitId == 408) {
        print("09876789");
        if (state.sourceOfIrrigationId == 377) {
          updateModel(
            nonIrrigated:
                (int.parse(landSize ?? '0') / 0.4046856422).toStringAsFixed(3),
            irrigated: "0",
          );
        } else {
          updateModel(
            irrigated:
                (int.parse(landSize ?? '0') / 0.4046856422).toStringAsFixed(3),
            nonIrrigated: "0",
          );
        }
      } else {
        updateModel(
          irrigated: "0",
        );
      }
    }
  }

  void clearAllData(){
    emit(AddLandIrrigatedNonIrrigatedCubitModel());
  }
}
