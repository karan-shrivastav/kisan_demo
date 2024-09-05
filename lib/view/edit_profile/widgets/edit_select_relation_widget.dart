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

class EditSelectRelationWidget extends StatefulWidget {
  final TextEditingController relationTextEditingController;
  const EditSelectRelationWidget(
      {super.key, required this.relationTextEditingController});

  @override
  State<EditSelectRelationWidget> createState() =>
      _EditSelectRelationWidgetState();
}

class _EditSelectRelationWidgetState extends State<EditSelectRelationWidget> {
  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  bool _hasReligionError = false;

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
            controller: widget.relationTextEditingController,
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
                    errorStyle: const TextStyle(color: Colors.red),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    labelStyle:
                        const TextStyle(color: AppColors.textBlackColor),
                    suffixIcon: const Icon(Icons.arrow_drop_down)),

                onChanged: (value) {
                  final mainValidationError =
                      AppFormValidation.validateReligion(value);
                  if (mainValidationError != null) {
                    setState(() {
                      _hasReligionError = true;
                      print('_hasReligionError : $_hasReligionError');
                    });
                  }

                  context.read<FarmerFamilyMemberCubit>().updateModel(
                        relationName: value,
                      );
                },

                // onChanged: (value) {
                //   context
                //       .read<CreateFarmerUserInfoCubit>()
                //       .updateModel(relativeName: value);
                // },
              );
            },
            itemBuilder: (context, idProof) {
              return ListTile(
                title: Text(idProof),
              );
            },
            onSelected: (selectedIdProof) {
              widget.relationTextEditingController.text = selectedIdProof;
              List<RelationShipDataList>? identityTypeList = state
                  .getRealtionshipResponseModel.dataList
                  ?.where((item) => item.value == selectedIdProof)
                  .toList();
              if (identityTypeList != null && identityTypeList.isNotEmpty) {
                context.read<FarmerFamilyMemberCubit>().updateModel(
                      nomineeRelationId: identityTypeList[0].id,
                      relationName: identityTypeList[0].value,
                    );
                if (kDebugMode) {
                  print("Corresponding ID: ${identityTypeList[0].id}");
                }
              }
              setState(() {
                _hasReligionError = false;
              });
            },
          );
        }
        return CommonTextField(
          enabled: false,
          suffixIcon: Icons.arrow_drop_down,
          labelText: AppLocalizations.of(context)!.pleaseSelectRelation,
        );
      },
    );
  }
}
