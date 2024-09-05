import 'package:ekisan_credit/cubit/joint_applicant/loan_applicant_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../bloc/relationships/relationship_bloc.dart';
import '../../../../bloc/relationships/relationship_data_state.dart';
import '../../../../cubit/joint_applicant/joint_applicant_cubit.dart';
import '../../../../model/response/relationship_response_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RelationWidget extends StatefulWidget {
  const RelationWidget({super.key});

  @override
  State<RelationWidget> createState() => _RelationWidgetState();
}

class _RelationWidgetState extends State<RelationWidget> {
  final TextEditingController _relationController = TextEditingController();

  List<String> getSuggestionsRelationship(
      String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelationshipDataBloc, RelationshipDataState>(
      builder: (BuildContext context, RelationshipDataState state) {
        if (state is GetRealationshipSuccess) {
          List<RelationShipDataList>? relationshipList =
              state.getRealtionshipResponseModel.dataList;
          List<String> relationValues =
              relationshipList?.map((item) => item.value ?? "").toList() ?? [];
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {});
            }
          });
          return TypeAheadField<String>(
            controller: _relationController,
            suggestionsCallback: (pattern) {
              return getSuggestionsRelationship(pattern, relationValues);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: AppFormValidation.validateRelation,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText:
                      AppLocalizations.of(context)!.relationWithApplicant,
                  labelStyle: const TextStyle(color: AppColors.outLineColor),
                ),
                onChanged: (value) {},
              );
            },
            itemBuilder: (context, relationship) {
              return ListTile(
                title: Text(relationship),
              );
            },
            onSelected: (selectedRelationship) {
              _relationController.text = selectedRelationship;

              List<RelationShipDataList>? relationTypeList = state
                  .getRealtionshipResponseModel.dataList
                  ?.where((item) => item.value == selectedRelationship)
                  .toList();

              context
                  .read<LoanJointApplicantInfoCubit>()
                  .updateModel(relationId: relationTypeList?[0].id);
            },
          );
        }
        return Container();
      },
      listener: (BuildContext context, RelationshipDataState state) {
        // if (state is GetRealationshipSuccess) {
        //   Future.delayed(const Duration(seconds: 1), () {
        //     setState(() {});
        //   });
        // }
      },
    );
  }
}
