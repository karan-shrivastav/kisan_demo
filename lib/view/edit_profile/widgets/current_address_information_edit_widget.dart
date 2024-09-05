import 'package:ekisan_credit/bloc/district/district_bloc.dart';
import 'package:ekisan_credit/bloc/district/district_state.dart';
import 'package:ekisan_credit/bloc/state/state_bloc.dart';
import 'package:ekisan_credit/bloc/state/state_state.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:ekisan_credit/view/edit_profile/widgets/village_dropdown_edit_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/state/state_event.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../bloc/village/get_village_state.dart';
import '../../../common_widget/common_description_text_field.dart';
import '../../../cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentAddressInformationEditWidget extends StatefulWidget {
  const CurrentAddressInformationEditWidget({super.key});

  @override
  State<CurrentAddressInformationEditWidget> createState() =>
      _CurrentAddressInformationEditWidget();
}

class _CurrentAddressInformationEditWidget
    extends State<CurrentAddressInformationEditWidget> {
  String selectedValue = "";
  List<AddressDto>? addressList = [];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "India", child: Text("India")),
    ];
    return menuItems;
  }

  List<String> getSuggestions(String query, List<String> statesList) {
    final List<String> suggestions = statesList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  List<String> getSuggestionsForDistrict(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _stateTextEditingController =
      TextEditingController();

  final TextEditingController _districtTextEditingController =
      TextEditingController();
  final TextEditingController _fullAddressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _villageTextEditingController =
      TextEditingController();

  @override
  void initState() {
    context.read<StateBloc>().add(GetAllState());

    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos;
      _fullAddressController.text = addressList?[0].address ?? '';
      _stateTextEditingController.text = addressList?[0].stateName ?? '';
      _districtTextEditingController.text = addressList?[0].districtName ?? '';
      _pinCodeController.text = addressList?[0].pincode ?? '';
      _villageTextEditingController.text = addressList?[0].villageName ?? '';

      final createFarmerCubit = context.read<CreateFarmerCurrentAddressCubit>();
      createFarmerCubit.updateModel(
        address: getFarmerResponseModel.data?.addressDtos?[0].address ?? '',
        pincode: getFarmerResponseModel.data?.addressDtos?[0].pincode ?? '',
        selectedVillageString: addressList?[0].villageName ?? '',
      );

      final districtRequest = {
        "stateId": getFarmerResponseModel.data?.addressDtos?[0].stateId,
      }; // Set the selected value to _selectedState
      context
          .read<DistrictBlocNew>()
          .add(GetAllDistrictByState(districtRequest: districtRequest));
      final villageRequest = {
        "districtId": getFarmerResponseModel.data?.addressDtos?[0].districtId,
        "search": ""
      };
      context
          .read<GetVillageNewBloc>()
          .add(GetAllVillageByDistrict(villageRequest: villageRequest));
    }

    super.initState();
  }

  final FocusNode _districtFocusNode = FocusNode();
  List<String> getSuggestionsForVillage(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  void dispose() {
    _districtTextEditingController.dispose();
    _districtFocusNode.dispose();
    _villageTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createFarmerCurrentAddressCubit =
        context.read<CreateFarmerCurrentAddressCubit>();
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                AppTextWidget(
                  text: AppLocalizations.of(context)!.currentAddress,
                  fontWeight: FontWeight.w500,
                  fontSize: AppTextSize.contentSize16,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            CommonDescriptionTextField(
              controller: _fullAddressController,
              labelText: AppLocalizations.of(context)!.fullAddress,
              hintText: AppLocalizations.of(context)!.asPerAadhaar,
              validator: AppFormValidation.validateFullAddress,
              onChange: (value) {
                createFarmerCurrentAddressCubit.updateModel(address: value);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            /************* Sate ****************/
            BlocBuilder<StateBloc, StateState>(
              builder: (BuildContext context, StateState state) {
                if (state is GetStateSuccess) {
                  List<String> statesList = state
                          .getAllStateResponseModel.dataList
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
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.outLineColor),
                          ),
                          labelText: AppLocalizations.of(context)!.state,
                          labelStyle: const TextStyle(
                            color: AppColors.outLineColor,
                          ),
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        onChanged: (value) {
                          context
                              .read<CreateFarmerCurrentAddressCubit>()
                              .updateModel(
                                selectedStateString: value,
                              );
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
                      context
                          .read<CreateFarmerCurrentAddressCubit>()
                          .updateModel(
                              selectedDistrictString: "",
                              selectedVillageString: "");

                      final selectedStateObject =
                          state.getAllStateResponseModel.dataList?.firstWhere(
                              (item) => item.stateName == selectedState);

                      final districtRequest = {
                        "stateId": selectedStateObject?.id ?? ''
                      }; // Set the selected value to _selectedState
                      context.read<DistrictBlocNew>().add(GetAllDistrictByState(
                          districtRequest: districtRequest));

                      context
                          .read<CreateFarmerCurrentAddressCubit>()
                          .updateModel(
                            stateMasterId: selectedStateObject?.id,
                            selectedStateString: selectedState,
                          );
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

            /************* District  ****************/
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<CreateFarmerCurrentAddressCubit,
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
                            return getSuggestionsForDistrict(
                                pattern, districtList);
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
                                labelText:
                                    AppLocalizations.of(context)!.district,
                                labelStyle: TextStyle(
                                  color: AppColors.outLineColor,
                                ),
                                errorStyle: const TextStyle(color: Colors.red),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              onChanged: (value) {
                                context
                                    .read<CreateFarmerCurrentAddressCubit>()
                                    .updateModel(
                                      selectedDistrictString: value,
                                      selectedVillageString: "",
                                    );
                              },
                            );
                          },
                          itemBuilder: (context, idProof) {
                            return ListTile(
                              title: Text(idProof),
                            );
                          },
                          onSelected: (selectedDistrict) {
                            _districtTextEditingController.text =
                                selectedDistrict;
                            _villageTextEditingController.clear();
                            context
                                .read<CreateFarmerCurrentAddressCubit>()
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
                                .read<CreateFarmerCurrentAddressCubit>()
                                .updateModel(
                                  districtMasterId: selectedDistrictObject?.id,
                                  selectedDistrictString: selectedDistrict,
                                );
                          },
                        );
                      }
                      return CommonTextField(
                        enabled: false,
                        suffixIcon: Icons.arrow_drop_down,
                        labelText: AppLocalizations.of(context)!.district,
                      );
                    },
                  );
                }
                return CommonTextField(
                  enabled: false,
                  suffixIcon: Icons.arrow_drop_down,
                  labelText: AppLocalizations.of(context)!.district,
                );
              },
              listener: (BuildContext context,
                  CreateFarmerCurrentAddressCubitModel state) {},
            ),
            /************** Village/Locality ***********/
            const SizedBox(
              height: 16,
            ),

            BlocConsumer<CreateFarmerCurrentAddressCubit,
                CreateFarmerCurrentAddressCubitModel>(
              builder: (BuildContext context,
                  CreateFarmerCurrentAddressCubitModel state) {
                if (state.selectedStateString != "" &&
                    state.selectedDistrictString != "") {
                  return BlocBuilder<GetVillageNewBloc, GetVillageDataNewState>(
                    builder:
                        (BuildContext context, GetVillageDataNewState state) {
                      if (state is GetVillageSuccess) {
                        List<String> villageList = state
                                .getVillageResponseModel.dataList
                                ?.map((item) => item.villageName ?? "")
                                .toList() ??
                            [];
                        return TypeAheadField<String>(
                          controller: _villageTextEditingController,
                          suggestionsCallback: (pattern) {
                            return getSuggestionsForVillage(
                                pattern, villageList);
                          },
                          builder: (context, controller, focusNode) {
                            return TextFormField(
                              validator: AppFormValidation.validateVillage,
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                border: const OutlineInputBorder(),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.outLineColor),
                                ),
                                labelText: AppLocalizations.of(context)!
                                    .villageLocality,
                                labelStyle: const TextStyle(
                                    color: AppColors.outLineColor),
                              ),
                              onChanged: (value) {
                                context
                                    .read<CreateFarmerCurrentAddressCubit>()
                                    .updateModel(
                                      selectedVillageString: value,
                                    );
                              },
                            );
                          },
                          itemBuilder: (context, idProof) {
                            return ListTile(
                              title: Text(idProof),
                            );
                          },
                          onSelected: (selectedVillage) {
                            _villageTextEditingController.text =
                                selectedVillage;
                            final selectedVillageObject = state
                                .getVillageResponseModel.dataList
                                ?.firstWhere((item) =>
                                    item.villageName == selectedVillage);
                            context
                                .read<CreateFarmerCurrentAddressCubit>()
                                .updateModel(
                                  villageMasterId: selectedVillageObject?.id,
                                  selectedVillageString: selectedVillage,
                                );
                          },
                        );
                      } else {
                        return CommonTextField(
                            enabled: false,
                            suffixIcon: Icons.arrow_drop_down,
                            labelText:
                                AppLocalizations.of(context)!.villageLocality);
                      }
                    },
                  );
                }
                return CommonTextField(
                    enabled: false,
                    suffixIcon: Icons.arrow_drop_down,
                    labelText: AppLocalizations.of(context)!.villageLocality);
              },
              listener: (BuildContext context,
                  CreateFarmerCurrentAddressCubitModel state) {},
            ),
            //  const VillageDropDownEditWidget(),
            /*********** Pin code  ************/
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
                controller: _pinCodeController,
                labelText: AppLocalizations.of(context)!.pinCode,
                onChange: (value) {
                  createFarmerCurrentAddressCubit.updateModel(pincode: value);
                },
                vertical: 20,
                length: 6,
                keyboardType: TextInputType.number,
                validator: AppFormValidation.validatePinCode)
          ],
        )
      ],
    );
  }
}
