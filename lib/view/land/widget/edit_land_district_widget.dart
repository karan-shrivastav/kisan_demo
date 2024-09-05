import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/district/district_state.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/add_land/edit_land_cubit.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditLandDistrictWidget extends StatefulWidget {
  const EditLandDistrictWidget({super.key});

  @override
  State<EditLandDistrictWidget> createState() => _EditLandDistrictWidgetState();
}

class _EditLandDistrictWidgetState extends State<EditLandDistrictWidget> {
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
    // TODO: implement didChangeDependencies
    final editLandCubit = context.read<EditLandCubit>().state;
    _districtTextEditingController.text = editLandCubit.districtName ?? '';

    final districtRequest = {
      "stateId": editLandCubit.stateMasterId ?? ''
    }; // Set the selected value to _selectedState
    context.read<DistrictBlocNew>().add(GetAllDistrictByState(
        districtRequest: districtRequest));

    final villageRequest = {
      "districtId": editLandCubit.districtMasterId,
      "search":""

    };
    context.read<GetVillageNewBloc>().add(
      GetAllVillageByDistrict(villageRequest: villageRequest),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistrictBlocNew, DistrictStateNew>(
      builder: (BuildContext context, DistrictStateNew state) {
        if (state is GetDistrictSuccess) {
          List<String> districtList = state.getDistrictResponseModel.dataList
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
                decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.district,
                  labelStyle: const TextStyle(color: AppColors.outLineColor),
                ),
              );
            },
            itemBuilder: (context, idProof) {
              return ListTile(
                title: Text(idProof),
              );
            },
            onSelected: (selectedDistrict) {
              _districtTextEditingController.text = selectedDistrict;
              final selectedDistrictObject = state
                  .getDistrictResponseModel.dataList
                  ?.firstWhere((item) => item.districtName == selectedDistrict);
              final villageRequest = {
                "districtId": selectedDistrictObject?.id ?? '',
                "search":""
              };
              context.read<GetVillageNewBloc>().add(
                    GetAllVillageByDistrict(villageRequest: villageRequest),
                  );

              context.read<EditLandCubit>().updateModel(
                    districtMasterId: selectedDistrictObject?.id,
                  );
            },
          );
        } else {
          return CommonTextField(
            labelText: AppLocalizations.of(context)!.district,
            vertical: 20,
            enabled: false,
          );
        }
      },
    );
  }
}
