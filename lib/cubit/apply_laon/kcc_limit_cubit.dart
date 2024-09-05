import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/kcc_limit_model.dart';

class KccLimitCubit extends Cubit<List<KccCubitModel>> {
  KccLimitCubit() : super([]); // Initial empty list

  void addCrop(KccCubitModel crop) {
    state.add(crop); // Add the crop to the list
    emit(List.from(state)); // Emit updated list
  }
  void deleteCrop(int index) {
    state.removeAt(index); // Remove the crop at the specified index
    emit(List.from(state)); // Emit updated list
  }
  void clearAllData() {
    state.clear(); // Remove all crops from the list
    emit([]); // Emit updated list
  }
}
