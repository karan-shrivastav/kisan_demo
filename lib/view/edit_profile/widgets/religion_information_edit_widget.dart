import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReligionInformationEditWidget extends StatefulWidget {
  const ReligionInformationEditWidget({super.key});

  @override
  State<ReligionInformationEditWidget> createState() =>
      _ReligionInformationEditWidgetState();
}

class _ReligionInformationEditWidgetState
    extends State<ReligionInformationEditWidget> {
  TextEditingController religionTextEditingController = TextEditingController();

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  bool _hasReligionError = false;

  @override
  void initState() {
    final createFarmerUserPersonalInfo =
        context.read<CreateFarmerUserInfoCubit>().state;
    religionTextEditingController.text =
        createFarmerUserPersonalInfo.selectedRegionString ?? '';

    //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;

    religionTextEditingController.text =
        getFarmerResponseModel.data?.religion?.value ?? '';

    final createFarmerCubit = context.read<CreateFarmerUserInfoCubit>();
    createFarmerCubit.updateModel(
        religionId: getFarmerResponseModel.data?.religion?.id ?? 0,
        selectedRegionString:
            getFarmerResponseModel.data?.religion?.value ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
        builder: (BuildContext context, GetLovsTypeDataNewState state) {
          if (state is GetLovsTypeDataSuccess) {
            List<LovTypeDataList>? religionTypeList = state
                .lovsTypeResponseModel.dataList
                ?.where((item) => item.lovType == "RELIGIONNAME")
                .toList();

            // Extracting the identity type values from the filtered list
            List<String> idProofValues =
                religionTypeList?.map((item) => item.value ?? "").toList() ??
                    [];

            return TypeAheadField<String>(
              controller: religionTextEditingController,
              suggestionsCallback: (pattern) {
                return getSuggestions(
                    pattern, idProofValues.isNotEmpty ? idProofValues : []);
              },
              builder: (context, controller, focusNode) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  validator: AppFormValidation.validateReligion,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.outLineColor),
                    ),
                    labelText: AppLocalizations.of(context)!.selectReligion,
                    labelStyle: TextStyle(
                      color: _hasReligionError
                          ? Colors.red
                          : AppColors.outLineColor,
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    final mainValidationError =
                        AppFormValidation.validateReligion(value);
                    if (mainValidationError != null) {
                      setState(() {
                        _hasReligionError = true;
                      });
                    }
                    context
                        .read<CreateFarmerUserInfoCubit>()
                        .updateModel(selectedRegionString: value);
                  },
                );
              },
              itemBuilder: (context, idProof) {
                return ListTile(
                  title: Text(idProof),
                );
              },
              onSelected: (selectedIdProof) {
                religionTextEditingController.text = selectedIdProof;
                setState(() {
                  _hasReligionError = false;
                });
                List<LovTypeDataList>? religionTypeList = state
                    .lovsTypeResponseModel.dataList
                    ?.where((item) =>
                        item.lovType == "RELIGIONNAME" &&
                        item.value == selectedIdProof)
                    .toList();

                // Print the id of the first item found
                if (religionTypeList != null && religionTypeList.isNotEmpty) {
                  context.read<CreateFarmerUserInfoCubit>().updateModel(
                      religionId: religionTypeList[0].id,
                      selectedRegionString: selectedIdProof);
                  if (kDebugMode) {
                    print("Corresponding ID: ${religionTypeList[0].id}");
                  }
                }
              },
            );
          }

          return SizedBox(
            height: 56,
            child: TypeAheadField<String>(
              controller: religionTextEditingController,
              suggestionsCallback: (pattern) {
                return getSuggestions(pattern, []);
              },
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.outLineColor),
                    ),
                    labelText: AppLocalizations.of(context)!.selectReligion,
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
                religionTextEditingController.text = selectedIdProof;
              },
            ),
          );
        },
      ),
    );
  }
}
