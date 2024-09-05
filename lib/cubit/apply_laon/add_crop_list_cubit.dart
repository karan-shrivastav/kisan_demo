import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/add_crop_cubit_model.dart';
import '../model/create_farmer_current_address_cubit_model.dart';

class AddNewCropCubit extends Cubit<List<AddNewCropCubitModel>> {
  AddNewCropCubit() : super([]); // Initial empty list

  void addCrop(AddNewCropCubitModel crop) {
    state.add(crop); // Add the crop to the list
    emit(List.from(state)); // Emit updated list
  }
  void deleteCrop(int index) {
    state.removeAt(index); // Remove the crop at the specified index
    emit(List.from(state)); // Emit updated list
  }

  void clearCrops() {
    state.clear();
    emit([]); // Reset state to an empty list
  }
}
