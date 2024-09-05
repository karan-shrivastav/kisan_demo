import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_state.dart';
import '../../../cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VillageDropDownEditWidget extends StatefulWidget {
  const VillageDropDownEditWidget({super.key});

  @override
  State<VillageDropDownEditWidget> createState() =>
      _VillageDropDownEditWidgetState();
}

class _VillageDropDownEditWidgetState extends State<VillageDropDownEditWidget> {
  List<AddressDto>? addressList = [];
  final TextEditingController _villageTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForVillage(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  String districtName = "";

  @override
  void didChangeDependencies() {
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos;
      _villageTextEditingController.text = addressList?[0].villageName ?? '';
      districtName = addressList?[0].districtName ?? '';

      final createFarmerCubit = context.read<CreateFarmerCurrentAddressCubit>();
      createFarmerCubit.updateModel(
        selectedVillageString: addressList?[0].villageName ?? '',
      );
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateFarmerCurrentAddressCubit,
        CreateFarmerCurrentAddressCubitModel>(
      builder:
          (BuildContext context, CreateFarmerCurrentAddressCubitModel state) {
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
                      validator: AppFormValidation.validateVillage,
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.outLineColor),
                        ),
                        labelText:
                            AppLocalizations.of(context)!.villageLocality,
                        labelStyle:
                            const TextStyle(color: AppColors.outLineColor),
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
                    _villageTextEditingController.text = selectedVillage;
                    final selectedVillageObject =
                        state.getVillageResponseModel.dataList?.firstWhere(
                            (item) => item.villageName == selectedVillage);
                    context.read<CreateFarmerCurrentAddressCubit>().updateModel(
                          villageMasterId: selectedVillageObject?.id,
                          selectedVillageString: selectedVillage,
                        );
                  },
                );
              } else {
                return CommonTextField(
                    enabled: false,
                    suffixIcon: Icons.arrow_drop_down,
                    labelText: AppLocalizations.of(context)!.villageLocality);
              }
            },
          );
        }
        return CommonTextField(
            enabled: false,
            suffixIcon: Icons.arrow_drop_down,
            labelText: AppLocalizations.of(context)!.villageLocality);
      },
      listener:
          (BuildContext context, CreateFarmerCurrentAddressCubitModel state) {},
    );
  }
}
