import 'package:ekisan_credit/bloc/district/district_bloc.dart';
import 'package:ekisan_credit/bloc/state/state_bloc.dart';
import 'package:ekisan_credit/bloc/state/state_state.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:ekisan_credit/view/profile/widgets/district_drop_down_widget.dart';
import 'package:ekisan_credit/view/profile/widgets/village_drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/state/state_event.dart';
import '../../../common_widget/common_description_text_field.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentAddressInformationWidget extends StatefulWidget {
  const CurrentAddressInformationWidget({super.key});

  @override
  State<CurrentAddressInformationWidget> createState() =>
      _CurrentAddressInformationWidget();
}

class _CurrentAddressInformationWidget
    extends State<CurrentAddressInformationWidget> {
  String selectedValue = "";

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

  final TextEditingController _stateTextEditingController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    context.read<StateBloc>().add(GetAllState());
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool _hasState = false;

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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: _hasState
                                ? Colors.red
                                : AppColors.textBlackColor,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textBlackColor),
                          ),
                          labelText: AppLocalizations.of(context)!.state,
                          labelStyle: TextStyle(
                            color: _hasState
                                ? Colors.red
                                : AppColors.textBlackColor,
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
                                selectedStateString: "",
                                selectedDistrictString: "",
                                selectedVillageString: "",
                              );
                          final mainValidationError =
                              AppFormValidation.validateState(value);
                          if (mainValidationError != null) {
                            setState(() {
                              _hasState = true;
                            });
                          }
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
                      setState(() {
                        _hasState = false;
                      });

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
                              selectedStateString: selectedState);
                    },
                  );
                }
                return CommonTextField(
                    enabled: false,
                    suffixIcon: Icons.arrow_drop_down,
                    labelText: AppLocalizations.of(context)!.state);
              },
            ),

            /************* District  ****************/
            const SizedBox(
              height: 16,
            ),
            const DistrictDropDownWidget(),
            /************** Village/Locality ***********/
            const SizedBox(
              height: 16,
            ),
            const VillageDropDownWidget(),
            /*********** Pin code  ************/
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              labelText: AppLocalizations.of(context)!.pinCode,
              vertical: 20,
              length: 6,
              keyboardType: TextInputType.number,
              validator: AppFormValidation.validatePinCode,
              onChange: (value) {
                createFarmerCurrentAddressCubit.updateModel(pincode: value);
              },
            )
          ],
        )
      ],
    );
  }
}
