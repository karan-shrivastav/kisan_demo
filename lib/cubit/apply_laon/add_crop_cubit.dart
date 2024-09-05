import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../model/add_crop_model.dart';
import '../model/create_farmer_current_address_cubit_model.dart';

class AddCropCubit extends Cubit<AddCropCubitModel> {
  AddCropCubit() : super(AddCropCubitModel());

  void updateModel({
    String? landTypeId,
    String? landTypeName,
    String? croppingSeasonId,
    String? croppingSeasonName,
    String? cropId,
    String? cropName,
    String? areaUnitName,
    String? areaUnitId,
    double? mainAmount,
    String? totalInAcer,
    String? landSize,
  }) {
    emit(
      state.copyWith(
        landTypeId: landTypeId ?? state.landTypeId,
        landTypeName: landTypeName ?? state.landTypeName,
        croppingSeasonId: croppingSeasonId ?? state.croppingSeasonId,
        croppingSeasonName: croppingSeasonName ?? state.croppingSeasonName,
        cropId: cropId ?? state.cropId,
        areaUnitName: areaUnitName ?? state.areaUnitName,
        areaUnitId: areaUnitId ?? state.areaUnitId,
        cropName: cropName ?? state.cropName,
        mainAmount: mainAmount ?? state.mainAmount,
        totalInAcer: totalInAcer ?? state.totalInAcer,
        landSize: landSize ?? state.landSize,
      ),
    );
  }

  void clearData() {
    emit(AddCropCubitModel()); // Reset state to its initial values
  }
}
