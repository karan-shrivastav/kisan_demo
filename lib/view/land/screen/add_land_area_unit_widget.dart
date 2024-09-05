import 'package:ekisan_credit/cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLandAreaUnitWidget extends StatefulWidget {
  const AddLandAreaUnitWidget({super.key});

  @override
  State<AddLandAreaUnitWidget> createState() => _AddLandAreaUnitWidgetState();
}

class _AddLandAreaUnitWidgetState extends State<AddLandAreaUnitWidget> {
  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _areUnitTypeController = TextEditingController();
  final ValueNotifier<String> _selectedValue = ValueNotifier<String>("");

@override
  void initState() {
    // TODO: implement initState
  final lovsTypeData = [
    "AREAUNIT",
    "OWNERSHIP",
    "LANDTYPE",
    "SOURCEIRRIGATIONNAME",
    "GENDER",
    "NAMINGTITLE",
    "IDPROOF",
    "RELIGIONNAME",
    "CASTE",
    "OCCUPATION",
    "CROPPINGDETAIL"
  ];
  context.read<GetLovsTypeDataNewBloc>().add(
    GetLovsTypeDataNewList(
      bodyRequest: lovsTypeData,
    ),
  );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
      builder: (BuildContext context, GetLovsTypeDataNewState state) {
        if (state is GetLovsTypeDataSuccess) {
          List<LovTypeDataList>? identityTypeList = state
              .lovsTypeResponseModel.dataList
              ?.where((item) => item.lovType == "AREAUNIT")
              .toList();

          // Extracting the identity type values from the filtered list
          List<String> idProofValues =
              identityTypeList?.map((item) => item.value ?? "").toList() ?? [];

          return TypeAheadField<String>(
            controller: _areUnitTypeController,
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, idProofValues);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: AppFormValidation.areaUnit,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: const OutlineInputBorder(),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText:  AppLocalizations.of(context)!.areaUnitType,

                  labelStyle: const TextStyle(color: AppColors.outLineColor),
                ),
              );
            },
            itemBuilder: (context, idProof) {
              return ListTile(
                title: Text(idProof),
              );
            },
            onSelected: (selectedIdProof) {
              _areUnitTypeController.text = selectedIdProof;
              _selectedValue.value = selectedIdProof;
              List<LovTypeDataList>? identityTypeList = state
                  .lovsTypeResponseModel.dataList
                  ?.where((item) =>
                      item.lovType == "AREAUNIT" &&
                      item.value == selectedIdProof)
                  .toList();

              // Print the id of the first item found
              if (identityTypeList != null && identityTypeList.isNotEmpty) {
                context.read<AddLandIrrigatedNonIrrigatedCubit>().updateModel(
                      areaUnitId: identityTypeList[0].id,
                       irrigated: "0",
                       nonIrrigated: "0",
                       landSize: "0",
                      sourceOfIrrigationId: null
                    );
                Future.delayed(const Duration(seconds: 2), () {
                  context
                      .read<AddLandIrrigatedNonIrrigatedCubit>()
                      .calculateLandByUnitNew();
                });
                if (kDebugMode) {
                  print(
                      "Corresponding  ${selectedIdProof}ID: ${identityTypeList[0].id}");
                }
              }
            },
          );
        }

        return CommonTextField(
          labelText: AppLocalizations.of(context)!.areaUnitType,
          hintText: AppLocalizations.of(context)!.selectAnOption,
          enabled: false,
          onChange: (value) {},
        );
      },
    );
  }
}
