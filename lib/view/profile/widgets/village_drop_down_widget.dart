import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_state.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VillageDropDownWidget extends StatefulWidget {
  const VillageDropDownWidget({super.key});

  @override
  State<VillageDropDownWidget> createState() => _VillageDropDownWidgetState();
}

class _VillageDropDownWidgetState extends State<VillageDropDownWidget> {
  final TextEditingController _villageTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForVillage(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  bool _hasVillage = false;

  @override
  Widget build(BuildContext context) {
    final villageBloc =
        context.watch<GetVillageNewBloc>().getVillageResponseModel;
    return Column(
      children: [
        if (villageBloc.dataList != null)
          BlocConsumer<CreateFarmerCurrentAddressCubit,
              CreateFarmerCurrentAddressCubitModel>(
            builder: (BuildContext context,
                CreateFarmerCurrentAddressCubitModel state) {
              //  _villageTextEditingController.clear();
              print('district :${state.selectedDistrictString}');
              if (state.selectedStateString == "" ||
                  state.selectedDistrictString == "" ||
                  state.selectedStateString == null ||
                  state.selectedDistrictString == null) {
                _villageTextEditingController.clear();
              }
              if (state.selectedStateString != "" &&
                  state.selectedDistrictString != "" &&
                  state.selectedStateString != null &&
                  state.selectedDistrictString != null) {
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
                          return getSuggestionsForVillage(pattern, villageList);
                        },
                        builder: (context, controller, focusNode) {
                          return TextFormField(
                            controller: controller,
                            validator: AppFormValidation.validateVillage,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: _hasVillage
                                    ? Colors.red
                                    : AppColors.textBlackColor,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.outLineColor),
                              ),
                              labelText:
                                  AppLocalizations.of(context)!.villageLocality,
                              labelStyle: TextStyle(
                                color: _hasVillage
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
                              final mainValidationError =
                                  AppFormValidation.validateVillage(value);
                              if (mainValidationError != null) {
                                setState(() {
                                  _hasVillage = true;
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
                        onSelected: (selectedVillage) {
                          _villageTextEditingController.text = selectedVillage;
                          setState(() {
                            _hasVillage = false;
                          });
                          final selectedVillageObject = state
                              .getVillageResponseModel.dataList
                              ?.firstWhere((item) =>
                                  item.villageName == selectedVillage);

                          context
                              .read<CreateFarmerCurrentAddressCubit>()
                              .updateModel(
                                  villageMasterId: selectedVillageObject?.id,
                                  selectedVillageString: selectedVillage);
                        },
                      );
                    }
                    return Container();
                  },
                );
              }
              return CommonTextField(
                labelText: AppLocalizations.of(context)!.villageLocality,
                enabled: false,
                suffixIcon: Icons.arrow_drop_down,
              );
            },
            listener: (BuildContext context,
                CreateFarmerCurrentAddressCubitModel state) {},
          )
        else
          CommonTextField(
            labelText: AppLocalizations.of(context)!.villageLocality,
            enabled: false,
            suffixIcon: Icons.arrow_drop_down,
          )
      ],
    );
  }
}
