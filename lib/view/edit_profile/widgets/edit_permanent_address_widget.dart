import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/district/district_state.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/state/state_bloc.dart';
import '../../../bloc/state/state_event.dart';
import '../../../bloc/state/state_state.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../bloc/village/get_village_state.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPermanentAddressWidget extends StatefulWidget {
  const EditPermanentAddressWidget({super.key});

  @override
  State<EditPermanentAddressWidget> createState() =>
      _EditPermanentAddressWidgetState();
}

class _EditPermanentAddressWidgetState
    extends State<EditPermanentAddressWidget> {
  List<String> getSuggestions(String query, List<String> statesList) {
    final List<String> suggestions = statesList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _districtTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForDistrict(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _villageTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForVillage(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _stateTextEditingController =
      TextEditingController();

  List<AddressDto>? addressList = [];

  @override
  void didChangeDependencies() {
    context.read<StateBloc>().add(GetAllState());
    // context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos;
      _stateTextEditingController.text = addressList?[1].stateName ?? '';
      _districtTextEditingController.text = addressList?[1].districtName ?? '';
      _villageTextEditingController.text = addressList?[1].villageName ?? '';

      final permanentAddressCubit =
          context.read<CreateFarmerPermanentAddressCubit>();
      permanentAddressCubit.updateModel(
        selectedStateString: addressList?[1].stateName ?? '',
        selectedDistrictString: addressList?[1].districtName ?? '',
        selectedVillageString: addressList?[1].villageName ?? '',
      );

      final districtRequest = {
        "stateId": addressList?[1].id ?? ''
      }; // Set the selected value to _selectedState
      context
          .read<DistrictBlocNew>()
          .add(GetAllDistrictByState(districtRequest: districtRequest));

      final villageRequest = {
        "districtId": addressList?[1].districtId ?? '',
        "search": ""
      };
      context
          .read<GetVillageNewBloc>()
          .add(GetAllVillageByDistrict(villageRequest: villageRequest));
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _districtTextEditingController.dispose();
    _villageTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<StateBloc, StateState>(
          builder: (BuildContext context, StateState state) {
            if (state is GetStateSuccess) {
              List<String> statesList = state.getAllStateResponseModel.dataList
                      ?.map((item) => item.stateName ?? "")
                      .toList() ??
                  [];
              return TypeAheadField<String>(
                controller: _stateTextEditingController,
                suggestionsCallback: (pattern) {
                  return getSuggestions(pattern, statesList);
                },
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    validator: AppFormValidation.validateState,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.outLineColor),
                      ),
                      labelText: AppLocalizations.of(context)!.state,
                      labelStyle:
                          const TextStyle(color: AppColors.outLineColor),
                    ),
                    onChanged: (value) {
                      context
                          .read<CreateFarmerPermanentAddressCubit>()
                          .updateModel(selectedStateString: value);
                    },
                  );
                },
                itemBuilder: (context, idProof) {
                  return ListTile(
                    title: Text(idProof),
                  );
                },
                onSelected: (selectedState) {
                  _stateTextEditingController.text = selectedState;
                  _districtTextEditingController.clear();
                  _villageTextEditingController.clear();
                  context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                        selectedDistrictString: "",
                        selectedVillageString: "",
                      );

                  final selectedStateObject = state
                      .getAllStateResponseModel.dataList
                      ?.firstWhere((item) => item.stateName == selectedState);

                  final districtRequest = {
                    "stateId": selectedStateObject?.id ?? ''
                  }; // Set the selected value to _selectedState
                  context.read<DistrictBlocNew>().add(
                      GetAllDistrictByState(districtRequest: districtRequest));

                  context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                      stateMasterId: selectedStateObject?.id,
                      selectedStateString: selectedState);
                },
              );
            }
            return CommonTextField(
              enabled: false,
              suffixIcon: Icons.arrow_drop_down,
              labelText: AppLocalizations.of(context)!.state,
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),

        BlocConsumer<CreateFarmerPermanentAddressCubit,
            CreateFarmerCurrentAddressCubitModel>(
          builder: (BuildContext context,
              CreateFarmerCurrentAddressCubitModel state) {
            if (state.selectedStateString != "") {
              return BlocBuilder<DistrictBlocNew, DistrictStateNew>(
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
                              borderSide:
                                  BorderSide(color: AppColors.outLineColor),
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
                        _villageTextEditingController.clear();
                        context
                            .read<CreateFarmerPermanentAddressCubit>()
                            .updateModel(
                              selectedVillageString: "",
                            );
                        final selectedDistrictObject = state
                            .getDistrictResponseModel.dataList
                            ?.firstWhere((item) =>
                                item.districtName == selectedDistrict);
                        final villageRequest = {
                          "districtId": selectedDistrictObject?.id ?? '',
                          "search": ""
                        };
                        context.read<GetVillageNewBloc>().add(
                            GetAllVillageByDistrict(
                                villageRequest: villageRequest));
                        context
                            .read<CreateFarmerPermanentAddressCubit>()
                            .updateModel(
                                districtMasterId: selectedDistrictObject?.id,
                                selectedDistrictString: selectedDistrict);
                      },
                    );
                  } else {
                    // Return an empty container or a placeholder widget when the state is not GetDistrictSuccess
                    return CommonTextField(
                      suffixIcon: Icons.arrow_drop_down,
                      labelText: AppLocalizations.of(context)!.district,
                      vertical: 20,
                      enabled: false,
                    );
                  }
                },
              );
            }
            return CommonTextField(
              labelText: AppLocalizations.of(context)!.district,
              suffixIcon: Icons.arrow_drop_down,
              vertical: 20,
              enabled: false,
            );
          },
          listener: (BuildContext context,
              CreateFarmerCurrentAddressCubitModel state) {},
        ),
        /************** Village/Locality ***********/
        const SizedBox(
          height: 16,
        ),
        BlocConsumer<CreateFarmerPermanentAddressCubit,
            CreateFarmerCurrentAddressCubitModel>(
          builder: (BuildContext context,
              CreateFarmerCurrentAddressCubitModel state) {
            if (state.selectedStateString != "" &&
                state.selectedDistrictString != "") {
              return BlocBuilder<GetVillageNewBloc, GetVillageDataNewState>(
                builder: (BuildContext context, GetVillageDataNewState state) {
                  if (state is GetVillageSuccess) {
                    List<String> villageList = state
                            .getVillageResponseModel.dataList
                            ?.map((item) => item.villageName ?? "")
                            .toList() ??
                        [];
                    return TypeAheadField<String>(
                      controller: _villageTextEditingController,
                      suggestionsCallback: (pattern) {
                        return getSuggestionsForVillage(pattern, villageList);
                      },
                      builder: (context, controller, focusNode) {
                        return TextFormField(
                          controller: controller,
                          validator: AppFormValidation.validateVillage,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.outLineColor),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.villageLocality,
                            labelStyle:
                                const TextStyle(color: AppColors.outLineColor),
                          ),
                          onChanged: (value) {
                            context
                                .read<CreateFarmerPermanentAddressCubit>()
                                .updateModel(selectedVillageString: value);
                          },
                        );
                      },
                      itemBuilder: (context, idProof) {
                        return ListTile(
                          title: Text(idProof),
                        );
                      },
                      onSelected: (selectedVillage) {
                        _villageTextEditingController.text = selectedVillage;
                        final selectedVillageObject =
                            state.getVillageResponseModel.dataList?.firstWhere(
                                (item) => item.villageName == selectedVillage);

                        context
                            .read<CreateFarmerPermanentAddressCubit>()
                            .updateModel(
                                villageMasterId: selectedVillageObject?.id,
                                selectedVillageString: selectedVillage);
                      },
                    );
                  }
                  return CommonTextField(
                    labelText: AppLocalizations.of(context)!.villageLocality,
                    suffixIcon: Icons.arrow_drop_down,
                    vertical: 20,
                    enabled: false,
                  );
                },
              );
            }
            return CommonTextField(
              labelText: AppLocalizations.of(context)!.villageLocality,
              suffixIcon: Icons.arrow_drop_down,
              vertical: 20,
              enabled: false,
            );
          },
          listener: (BuildContext context,
              CreateFarmerCurrentAddressCubitModel state) {},
        ),
        // const VillageDropDownPermanentEditWidget(),
        /*********** Pin code  ************/
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
