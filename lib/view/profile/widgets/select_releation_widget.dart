import 'package:ekisan_credit/bloc/relationships/relationship_bloc.dart';
import 'package:ekisan_credit/bloc/relationships/relationship_data_state.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../model/response/relationship_response_model.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectRelationWidget extends StatefulWidget {
  const SelectRelationWidget({super.key});

  @override
  State<SelectRelationWidget> createState() => _SelectRelationWidgetState();
}

class _SelectRelationWidgetState extends State<SelectRelationWidget> {
  TextEditingController relationTextEditingController = TextEditingController();
  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationshipDataBloc, RelationshipDataState>(
      builder: (BuildContext context, RelationshipDataState state) {
        if (state is GetRealationshipSuccess) {
          List<String> idProofValues = state
                  .getRealtionshipResponseModel.dataList
                  ?.map((item) => item.value ?? "")
                  .toList() ??
              [];
          return TypeAheadField<String>(
            controller: relationTextEditingController,
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, idProofValues);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: AppFormValidation.validateRelation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.outLineColor),
                    ),
                    labelText:
                        AppLocalizations.of(context)!.relationWithApplicant,
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    labelStyle:
                        const TextStyle(color: AppColors.textBlackColor),
                    suffixIcon: const Icon(Icons.arrow_drop_down)),
                onChanged: (value) {
                  context
                      .read<FarmerFamilyMemberCubit>()
                      .updateModel(relationName: value,);
                },
              );
            },
            itemBuilder: (context, idProof) {
              return ListTile(
                title: Text(idProof),
              );
            },
            onSelected: (selectedIdProof) {
              relationTextEditingController.text = selectedIdProof;
              List<RelationShipDataList>? identityTypeList = state
                  .getRealtionshipResponseModel.dataList
                  ?.where((item) => item.value == selectedIdProof)
                  .toList();

              // Print the id of the first item found
              if (identityTypeList != null && identityTypeList.isNotEmpty) {
                context.read<FarmerFamilyMemberCubit>().updateModel(
                    nomineeRelationId: identityTypeList[0].id,
                    relationName: identityTypeList[0].value);

                if (kDebugMode) {
                  print("Corresponding ID: ${identityTypeList[0].id}");
                }
              }
            },
          );
        }
        return CommonTextField(
            enabled: false,
            suffixIcon: Icons.arrow_drop_down,
            labelText: AppLocalizations.of(context)!.pleaseSelectRelation);
      },
    );
  }
}
