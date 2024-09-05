import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../bloc/relationships/relationship_bloc.dart';
import '../../../../bloc/relationships/relationship_data_event.dart';
import '../../../../cubit/joint_applicant/loan_applicant_cubit.dart';
import '../../../../model/response/lovtype_type_response_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  final TextEditingController _genderController = TextEditingController();
  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  void initState() {
    final lovsTypeData = [
      "GENDER",
      "IDPROOF",
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
          List<LovTypeDataList>? genderList = state
              .lovsTypeResponseModel.dataList
              ?.where((item) => item.lovType == "GENDER")
              .toList();
          // Extracting the gender values from the filtered list
          List<String> genderValue =
              genderList?.map((item) => item.value ?? "").toList() ?? [];
          return TypeAheadField<String>(
            controller: _genderController,
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, genderValue);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: AppFormValidation.validateGender,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.gender,
                  labelStyle: const TextStyle(color: AppColors.outLineColor),
                ),
              );
            },
            itemBuilder: (context, gender) {
              return ListTile(
                title: Text(gender),
              );
            },
            onSelected: (selectedGender) {
              _genderController.text = selectedGender;
              //  _selectedValue.value = selectedGender;
              List<LovTypeDataList>? genderList = state
                  .lovsTypeResponseModel.dataList
                  ?.where((item) =>
                      item.lovType == "GENDER" && item.value == selectedGender)
                  .toList();
              context
                  .read<LoanJointApplicantInfoCubit>()
                  .updateModel(genderId: genderList?[0].id);
              final loanJointInfoCubit =
                  context.read<LoanJointApplicantInfoCubit>();
              if (kDebugMode) {
                print('This is Id : ${loanJointInfoCubit.state.genderId ?? ''}');
              }
              context.read<RelationshipDataBloc>().add(GetRelationshipList(
                  bodyRequest: ['${loanJointInfoCubit.state.genderId ?? ''}']));
            },
          );
        }
        return Container();
      },
    );
  }
}
