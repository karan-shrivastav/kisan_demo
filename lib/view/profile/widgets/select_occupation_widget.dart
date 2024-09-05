import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectOccupationWidget extends StatefulWidget {
  const SelectOccupationWidget({super.key});

  @override
  State<SelectOccupationWidget> createState() => _SelectOccupationWidgetState();
}

class _SelectOccupationWidgetState extends State<SelectOccupationWidget> {
  TextEditingController selectOccupationTextEditingController =
      TextEditingController();

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
    selectOccupationTextEditingController.text =
        createFarmerUserPersonalInfo.selectedOccupationString ?? '';
    super.didChangeDependencies();
  }
  bool _hasOccupation = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
        builder: (BuildContext context, GetLovsTypeDataNewState state) {
          if (state is GetLovsTypeDataSuccess) {
            List<LovTypeDataList>? religionTypeList = state
                .lovsTypeResponseModel.dataList
                ?.where((item) => item.lovType == "OCCUPATION")
                .toList();

            // Extracting the identity type values from the filtered list
            List<String> idProofValues =
                religionTypeList?.map((item) => item.value ?? "").toList() ??
                    [];

            return TypeAheadField<String>(
              controller: selectOccupationTextEditingController,
              suggestionsCallback: (pattern) {
                return getSuggestions(pattern, idProofValues);
              },
              builder: (context, controller, focusNode) {
                return TextFormField(
                  controller: controller,
                  validator: AppFormValidation.validateOccupation,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: focusNode,
                  // decoration: InputDecoration(
                  //   border: OutlineInputBorder(),
                  //   focusedBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: AppColors.outLineColor),
                  //   ),
                  //   labelText: AppLocalizations.of(context)!.selectOccupation,
                  //   labelStyle: TextStyle(color: AppColors.outLineColor),
                  // ),

                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.outLineColor),
                    ),
                    labelText:AppLocalizations.of(context)!.selectOccupation,
                    labelStyle: TextStyle(
                      color: _hasOccupation ? Colors.red : AppColors.textBlackColor,
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value){
                    final mainValidationError = AppFormValidation.validateOccupation(value);
                    if (mainValidationError != null) {
                      setState(() {
                        _hasOccupation = true;
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
              onSelected: (selectedIdProof) {
                selectOccupationTextEditingController.text = selectedIdProof;
                setState(() {
                  _hasOccupation = false;
                });

                List<LovTypeDataList>? religionTypeList = state
                    .lovsTypeResponseModel.dataList
                    ?.where((item) =>
                        item.lovType == "OCCUPATION" &&
                        item.value == selectedIdProof)
                    .toList();

                // Print the id of the first item found
                if (religionTypeList != null && religionTypeList.isNotEmpty) {
                  context.read<CreateFarmerUserInfoCubit>().updateModel(
                      occupationId: religionTypeList[0].id,
                      selectedOccupationString: selectedIdProof);
                  if (kDebugMode) {
                    print("Corresponding ID: ${religionTypeList[0].id}");
                  }
                }
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
