import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/asset_id_cubit_model.dart';

class AssetIdCubit extends Cubit<AssetCubitIdModel> {
  AssetIdCubit() : super(AssetCubitIdModel());

  void updateModel({
    int? movableId,
    int? immovableId,

  }) {
    emit(state.copyWith(
        movableId: movableId ?? state.movableId,
        immovableId: immovableId ?? state.immovableId,
        ));
  }

  void clearData() {
    emit(AssetCubitIdModel()); // Reset state to its initial values
  }
}
