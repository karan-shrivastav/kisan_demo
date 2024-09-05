import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../bloc/village/get_village_state.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VillageDropDownPermanentEditWidget extends StatefulWidget {
  const VillageDropDownPermanentEditWidget({super.key});

  @override
  State<VillageDropDownPermanentEditWidget> createState() =>
      _VillageDropDownPermanentEditWidgetState();
}

class _VillageDropDownPermanentEditWidgetState
    extends State<VillageDropDownPermanentEditWidget> {
  final TextEditingController _villageTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForVillage(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  List<AddressDto> addressList = [];

  @override
  void didChangeDependencies() {
    //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos ?? [];
      _villageTextEditingController.text = addressList[1].villageName ?? '';
      final permanentAddressCubit =
          context.read<CreateFarmerPermanentAddressCubit>();
      permanentAddressCubit.updateModel(
        selectedVillageString: addressList[1].villageName ?? '',
      );

      final villageRequest = {
        "districtId": addressList[1].districtId ?? '',
        "search": ""
      };
      context
          .read<GetVillageNewBloc>()
          .add(GetAllVillageByDistrict(villageRequest: villageRequest));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetVillageNewBloc, GetVillageDataNewState>(
      builder: (BuildContext context, GetVillageDataNewState state) {
        if (state is GetVillageSuccess) {
          List<String> villageList = state.getVillageResponseModel.dataList
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
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.villageLocality,
                  labelStyle: const TextStyle(color: AppColors.outLineColor),
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
              final selectedVillageObject = state
                  .getVillageResponseModel.dataList
                  ?.firstWhere((item) => item.villageName == selectedVillage);

              context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                  villageMasterId: selectedVillageObject?.id,
                  selectedVillageString: selectedVillage);
            },
          );
        }
        return CommonTextField(
          labelText: AppLocalizations.of(context)!.villageLocality,
          vertical: 20,
          enabled: false,
        );
      },
    );
  }
}
