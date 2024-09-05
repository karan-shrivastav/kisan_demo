import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/create_farmer_current_address_cubit_model.dart';

class CreateFarmerPermanentAddressCubit
    extends Cubit<CreateFarmerCurrentAddressCubitModel> {
  CreateFarmerPermanentAddressCubit()
      : super(CreateFarmerCurrentAddressCubitModel());

  void updateModel({
    int? stateMasterId,
    String? selectedStateString,
    int? districtMasterId,
    String? selectedDistrictString,
    int? villageMasterId,
    String? selectedVillageString,
    String? address,
    String? enteredAddressString,
    String? pincode,
    String? addressType,
    bool? isAddressSame,
  }) {
    emit(state.copyWith(
        stateMasterId: stateMasterId ?? state.stateMasterId,
        selectedStateString: selectedStateString ?? state.selectedStateString,
        districtMasterId: districtMasterId ?? state.districtMasterId,
        selectedDistrictString:
        selectedDistrictString ?? state.selectedDistrictString,
        villageMasterId: villageMasterId ?? state.villageMasterId,
        selectedVillageString:
        selectedVillageString ?? state.selectedVillageString,
        address: address ?? state.address,
        pincode: pincode ?? state.pincode,
        addressType: addressType ?? state.addressType,
        isAddressSame: isAddressSame ?? state.isAddressSame));
  }
}
