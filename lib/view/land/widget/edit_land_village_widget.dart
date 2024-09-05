import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/village/get_vilage_bloc.dart';
import '../../../bloc/village/get_village_event.dart';
import '../../../bloc/village/get_village_state.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/add_land/edit_land_cubit.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditLandVillageWidget extends StatefulWidget {
  const EditLandVillageWidget({super.key});

  @override
  State<EditLandVillageWidget> createState() => _EditLandVillageWidgetState();
}

class _EditLandVillageWidgetState extends State<EditLandVillageWidget> {
  final TextEditingController _villageTextEditingController =
      TextEditingController();

  List<String> getSuggestionsForVillage(
      String query, List<String> districtList) {
    final List<String> suggestions = districtList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final editLandCubit = context.read<EditLandCubit>().state;
    final villageRequest = {
      "districtId": editLandCubit.districtMasterId,
      "search": ""
    };
    context.read<GetVillageNewBloc>().add(
          GetAllVillageByDistrict(villageRequest: villageRequest),
        );
    _villageTextEditingController.text = editLandCubit.villageName ?? '';
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
              return TextField(
                controller: controller,
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
              context.read<EditLandCubit>().updateModel(
                    villageId: selectedVillageObject?.id,
                  );
            },
          );
        } else {
          return CommonTextField(
              enabled: false,
              labelText: AppLocalizations.of(context)!.villageLocality);
        }
      },
    );
  }
}
