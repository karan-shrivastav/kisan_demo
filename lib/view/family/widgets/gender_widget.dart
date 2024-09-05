import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final farmerFamilyMemberCubit = context.read<FarmerFamilyMemberCubit>();
    return BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
      builder: (BuildContext context, GetLovsTypeDataNewState state) {
        if (state is GetLovsTypeDataSuccess) {
          List<LovTypeDataList>? genderList = state
              .lovsTypeResponseModel.dataList
              ?.where((item) => item.lovType == "GENDER")
              .toList();

          // Extracting the gender values from the filtered list
          List<String> namingValue =
              genderList?.map((item) => item.value ?? "").toList() ?? [];

          // Assuming TwoAndThreeDividedHeaders is a widget to display headers
          return ValueListenableBuilder(
            valueListenable: _isGenderFilled,
            builder: (BuildContext context, value, Widget? child) {
              return Column(
                children: [
                  TwoAndThreeDividedHeaders(
                    heightBetweenContentAndTitle: 10,
                    padding: EdgeInsets.zero,
                    title: AppLocalizations.of(context)!.gender,
                    contentList: namingValue,
                    showError: value,
                    onValueSelected: (String selectedGender) {
                      // Filter naming titles list based on selected gender
                      List<LovTypeDataList>? genderList = state
                          .lovsTypeResponseModel.dataList
                          ?.where((item) =>
                      item.lovType == "GENDER" &&
                          item.value == selectedGender)
                          .toList();

                      // Print the id of the first item found
                      if (genderList != null && genderList.isNotEmpty) {
                        farmerFamilyMemberCubit.updateModel(
                            genderId: genderList[0].id);
                        if (farmerFamilyMemberCubit.state.genderId == null) {
                          _isGenderFilled.value = true;
                        } else {
                          _isGenderFilled.value = false;
                        }
                        context.read<RelationshipDataBloc>().add(
                            GetRelationshipList(
                                bodyRequest: [genderList[0].id.toString()]));

                        if (kDebugMode) {
                          print(
                              "Selected gender: $selectedGender, Corresponding ID: ${genderList[0].id}");
                        }
                      } else {
                        if (kDebugMode) {
                          print(
                              "No naming title found for selected gender: $selectedGender");
                        }
                      }
                      if (kDebugMode) {
                        print("Selected gender: $selectedGender");
                      }
                    },
                  ),
                   if (value)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 16),
                          child: AppTextWidget(
                            text: AppLocalizations.of(context)!
                                .pleaseSelectGender,
                            fontSize: 12,
                            textColor: AppColors.errorColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        }
        return Container();
      },
     // listener: (BuildContext context, GetLovsTypeDataNewState state) {},
    );
  }
}