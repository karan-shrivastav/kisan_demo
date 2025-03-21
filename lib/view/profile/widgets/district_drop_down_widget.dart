import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_state.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DistrictDropDownWidget extends StatefulWidget {
  const DistrictDropDownWidget({super.key});

  @override
  State<DistrictDropDownWidget> createState() => _DistrictDropDownWidgetState();
}

class _DistrictDropDownWidgetState extends State<DistrictDropDownWidget> {
  final TextEditingController _districtTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForDistrict(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  bool _hasDistrict = false;
  @override
  Widget build(BuildContext context) {
    final districtBloc =
        context.watch<DistrictBlocNew>().getDistrictResponseModel;
    return Column(
      children: [
        if (districtBloc.dataList != null)
          BlocConsumer<CreateFarmerCurrentAddressCubit,
              CreateFarmerCurrentAddressCubitModel>(
            builder: (BuildContext context,
                CreateFarmerCurrentAddressCubitModel state) {
              if (state.selectedStateString == "" ||
                  state.selectedStateString == null) {
                _districtTextEditingController.clear();
              }
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: _hasDistrict
                                    ? Colors.red
                                    : AppColors.textBlackColor,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.outLineColor),
                              ),
                              labelText: AppLocalizations.of(context)!.district,
                              labelStyle: TextStyle(
                                color: _hasDistrict
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
                                    selectedDistrictString: "",
                                    selectedVillageString: "",
                                  );
                              final mainValidationError =
                                  AppFormValidation.validateDistrict(value);
                              if (mainValidationError != null) {
                                setState(() {
                                  _hasDistrict = true;
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
                        onSelected: (selectedDistrict) {
                          _districtTextEditingController.text =
                              selectedDistrict;
                          setState(() {
                            _hasDistrict = false;
                          });
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
                                  selectedDistrictString: selectedDistrict);
                        },
                      );
                    } else {
                      // Return an empty container or a placeholder widget when the state is not GetDistrictSuccess
                      return Container();
                    }
                  },
                );
              }
              return CommonTextField(
                labelText: AppLocalizations.of(context)!.district,
                suffixIcon: Icons.arrow_drop_down,
                enabled: false,
              );
            },
            listener: (BuildContext context,
                CreateFarmerCurrentAddressCubitModel state) {},
          )
        else
          CommonTextField(
            labelText: AppLocalizations.of(context)!.district,
            suffixIcon: Icons.arrow_drop_down,
            enabled: false,
          )
      ],
    );
  }
}
