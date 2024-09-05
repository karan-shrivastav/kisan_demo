import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/district/district_state.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DistrictDropDownPermanentEditWidget extends StatefulWidget {
  const DistrictDropDownPermanentEditWidget({super.key});

  @override
  State<DistrictDropDownPermanentEditWidget> createState() =>
      _DistrictDropDownPermanentEditWidgetState();
}

class _DistrictDropDownPermanentEditWidgetState
    extends State<DistrictDropDownPermanentEditWidget> {
  final TextEditingController _districtTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForDistrict(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  List<AddressDto> addressList = [];

  @override
  void didChangeDependencies() {
  //  context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos ?? [];
      _districtTextEditingController.text = addressList[1].districtName ?? '';

      final permanentAddressCubit =
          context.read<CreateFarmerPermanentAddressCubit>();
      permanentAddressCubit.updateModel(
        selectedDistrictString: addressList[1].districtName ?? '',
      );

      final districtRequest = {
        "stateId": addressList[1].id ?? ''
      }; // Set the selected value to _selectedState
      context
          .read<DistrictBlocNew>()
          .add(GetAllDistrictByState(districtRequest: districtRequest));
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DistrictBlocNew, DistrictStateNew>(
          builder: (BuildContext context, DistrictStateNew state) {
            if (state is GetDistrictSuccess) {
              List<String> districtList = state
                      .getDistrictResponseModel.dataList
                      ?.map((item) => item.districtName ?? "")
                      .toList() ??
                  [];
              return TypeAheadField<String>(
                controller: _districtTextEditingController,
                suggestionsCallback: (pattern) {
                  return getSuggestionsForDistrict(pattern, districtList);
                },
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    validator: AppFormValidation.validateDistrict,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.outLineColor),
                      ),
                      labelText: AppLocalizations.of(context)!.district,
                      labelStyle:
                          const TextStyle(color: AppColors.outLineColor),
                    ),
                    onChanged: (value) {
                      context
                          .read<CreateFarmerPermanentAddressCubit>()
                          .updateModel(selectedDistrictString: value);
                    },
                  );
                },
                itemBuilder: (context, idProof) {
                  return ListTile(
                    title: Text(idProof),
                  );
                },
                onSelected: (selectedDistrict) {
                  _districtTextEditingController.text = selectedDistrict;
                  final selectedDistrictObject =
                      state.getDistrictResponseModel.dataList?.firstWhere(
                          (item) => item.districtName == selectedDistrict);
                  final villageRequest = {
                    "districtId": selectedDistrictObject?.id ?? '',
                    "search": ""
                  };
                  context.read<GetVillageNewBloc>().add(
                      GetAllVillageByDistrict(villageRequest: villageRequest));

                  context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                      districtMasterId: selectedDistrictObject?.id,
                      selectedDistrictString: selectedDistrict);
                },
              );
            } else {
              // Return an empty container or a placeholder widget when the state is not GetDistrictSuccess
              return CommonTextField(
                labelText: AppLocalizations.of(context)!.district,
                vertical: 20,
                enabled: false,
              );
            }
          },
        )
      ],
    );
  }
}
