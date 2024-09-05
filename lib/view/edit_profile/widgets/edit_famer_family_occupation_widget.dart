import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import '../../../cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditFarmerFamilyOccupationWidget extends StatefulWidget {
  final TextEditingController selectOccupationTextEditingController;

  const EditFarmerFamilyOccupationWidget({
    super.key,
    required this.selectOccupationTextEditingController,
  });

  @override
  State<EditFarmerFamilyOccupationWidget> createState() =>
      _EditFarmerFamilyOccupationWidgetState();
}

class _EditFarmerFamilyOccupationWidgetState
    extends State<EditFarmerFamilyOccupationWidget> {
  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  void didChangeDependencies() {
    final createFarmerUserPersonalInfo =
        context.read<CreateFarmerUserInfoCubit>().state;
    widget.selectOccupationTextEditingController.text =
        createFarmerUserPersonalInfo.selectedOccupationString ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
      builder: (BuildContext context, GetLovsTypeDataNewState state) {
        if (state is GetLovsTypeDataSuccess) {
          List<LovTypeDataList>? religionTypeList = state
              .lovsTypeResponseModel.dataList
              ?.where((item) => item.lovType == "OCCUPATION")
              .toList();

          // Extracting the identity type values from the filtered list
          List<String> idProofValues =
              religionTypeList?.map((item) => item.value ?? "").toList() ?? [];

          return TypeAheadField<String>(
            controller: widget.selectOccupationTextEditingController,
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, idProofValues);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                validator: AppFormValidation.validateOccupation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.selectOccupation,
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
              widget.selectOccupationTextEditingController.text =
                  selectedIdProof;

              List<LovTypeDataList>? occupationTypeList = state
                  .lovsTypeResponseModel.dataList
                  ?.where((item) =>
                      item.lovType == "OCCUPATION" &&
                      item.value == selectedIdProof)
                  .toList();

              // Print the id of the first item found
              if (occupationTypeList != null && occupationTypeList.isNotEmpty) {
                context
                    .read<FarmerFamilyMemberCubit>()
                    .updateModel(nomineeOccupationId: occupationTypeList[0].id);
                if (kDebugMode) {
                  print("Corresponding ID: ${occupationTypeList[0].id}");
                }
              }
            },
          );
        }

        return Container();
      },
    );
  }
}
