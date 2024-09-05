import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLandSourceOfIrrigationWidget extends StatefulWidget {
  const AddLandSourceOfIrrigationWidget({super.key});

  @override
  State<AddLandSourceOfIrrigationWidget> createState() =>
      _AddLandSourceOfIrrigationWidgetState();
}

class _AddLandSourceOfIrrigationWidgetState
    extends State<AddLandSourceOfIrrigationWidget> {
  final TextEditingController _sourceOfIrrigationController =
      TextEditingController();
  final ValueNotifier<String> _selectedValue = ValueNotifier<String>("");

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
      builder: (BuildContext context, GetLovsTypeDataNewState state) {
        if (state is GetLovsTypeDataSuccess) {
          List<LovTypeDataList>? identityTypeList = state
              .lovsTypeResponseModel.dataList
              ?.where((item) => item.lovType == "SOURCEIRRIGATIONNAME")
              .toList();

          // Extracting the identity type values from the filtered list
          List<String> idProofValues =
              identityTypeList?.map((item) => item.value ?? "").toList() ?? [];

          return TypeAheadField<String>(
            controller: _sourceOfIrrigationController,
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, idProofValues);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: AppFormValidation.sourceOfIrrigation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.sourceOfIrrigation,
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
              _sourceOfIrrigationController.text = selectedIdProof;
              _selectedValue.value = selectedIdProof;
              List<LovTypeDataList>? identityTypeList = state
                  .lovsTypeResponseModel.dataList
                  ?.where((item) =>
                      item.lovType == "SOURCEIRRIGATIONNAME" &&
                      item.value == selectedIdProof)
                  .toList();

              // Print the id of the first item found
              if (identityTypeList != null && identityTypeList.isNotEmpty) {
                context.read<CreateFarmerUserInfoCubit>().updateModel(
                    proofOfIdentityId: identityTypeList[0].id,
                    selectedProofOfIdentityString: selectedIdProof);
                context
                    .read<AddLandIrrigatedNonIrrigatedCubit>()
                    .updateModel(sourceOfIrrigationId: identityTypeList[0].id);
                // print(context.read<AddLandIrrigatedNonIrrigatedCubit>().state.areaUnitId);
                context
                    .read<AddLandIrrigatedNonIrrigatedCubit>()
                    .calculateLandByUnitNew();
                if (kDebugMode) {
                  print(
                      "Corresponding  ${selectedIdProof}ID: ${identityTypeList[0].id}");
                }
              }
            },
          );
        }

        return CommonTextField(
          labelText: AppLocalizations.of(context)!.sourceOfIrrigation,
          hintText: AppLocalizations.of(context)!.selectAnOption,
          enabled: false,
          onChange: (value) {},
        );
      },
    );
  }
}
