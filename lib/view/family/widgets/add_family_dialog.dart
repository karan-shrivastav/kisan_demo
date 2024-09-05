import 'package:ekisan_credit/bloc/family/add_family_member_bloc.dart';
import 'package:ekisan_credit/bloc/family/add_family_member_event.dart';
import 'package:ekisan_credit/cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/family/add_family_member_state.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_alert_dialog.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../profile/widgets/select_releation_widget.dart';
import 'farmer_family_occupation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFamilyDialog extends StatelessWidget {
  AddFamilyDialog({super.key});

  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final createFarmerUserInfoCubit = context.read<CreateFarmerUserInfoCubit>();
    final farmerFamilyMemberCubit = context.read<FarmerFamilyMemberCubit>();
    return AppAlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               AppTextWidget(
                text: AppLocalizations.of(context)!.addFamilyInformation,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 16,
              ),
              CommonTextField(
                  labelText: AppLocalizations.of(context)!.fullName,
                  hintText: AppLocalizations.of(context)!.asPerAadhaar,
                  vertical: 20,
                  validator: (value)=> AppFormValidation.validateName(context,value),
                  onChange: (value) {
                    farmerFamilyMemberCubit.updateModel(nomineeName: value);
                  }),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                labelText:AppLocalizations.of(context)!.age,
                hintText: AppLocalizations.of(context)!.age,
                validator: AppFormValidation.validateAge,
                keyboardType: TextInputType.number,
                vertical: 20,
                onChange: (value) {
                  farmerFamilyMemberCubit.updateModel(nomineeAge: value);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                builder: (BuildContext context, GetLovsTypeDataNewState state) {
                  if (state is GetLovsTypeDataSuccess) {
                    List<LovTypeDataList>? genderList = state
                        .lovsTypeResponseModel.dataList
                        ?.where((item) => item.lovType == "GENDER")
                        .toList();

                    // Extracting the gender values from the filtered list
                    List<String> namingValue =
                        genderList?.map((item) => item.value ?? "").toList() ??
                            [];

                    // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                    return ValueListenableBuilder(
                      valueListenable: _isGenderFilled,
                      builder: (BuildContext context, value, Widget? child) {
                        return Column(
                          children: [
                            TwoAndThreeDividedHeaders(
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
                                  if (farmerFamilyMemberCubit.state.genderId ==
                                      null) {
                                    _isGenderFilled.value = true;
                                  } else {
                                    _isGenderFilled.value = false;
                                  }
                                  context.read<RelationshipDataBloc>().add(
                                          GetRelationshipList(bodyRequest: [
                                        genderList[0].id.toString()
                                      ]));

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
                                        text: AppLocalizations.of(context)!.pleaseSelectGender,
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
                listener:
                    (BuildContext context, GetLovsTypeDataNewState state) {},
              ),
              const SizedBox(
                height: 10,
              ),
              const SelectRelationWidget(),
              const SizedBox(
                height: 10,
              ),
              const FarmerFamilyOccupationWidget(),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                showPrefixIcon: true,
                prefixIcon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
                labelText: AppLocalizations.of(context)!.annualIncome,
                hintText: AppLocalizations.of(context)!.annualIncome,
                vertical: 20,
                validator: AppFormValidation.validateIncome,
                onChange: (value) {
                  farmerFamilyMemberCubit.updateModel(annualIncome: value);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child:  CommonButton(
                        buttonName:AppLocalizations.of(context)!.cancell,
                        buttonColor: AppColors.whiteColor,
                        borderColor: AppColors.secondOutLineColor,
                        buttonTextColor: AppColors.secondOutLineColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child:
                        BlocConsumer<AddFamilyMemberBloc, AddFamilyMemberState>(
                      builder:
                          (BuildContext context, AddFamilyMemberState state) {
                        return InkWell(
                          onTap: () {
                            if (farmerFamilyMemberCubit.state.genderId ==
                                null) {
                              _isGenderFilled.value = true;
                            } else {
                              _isGenderFilled.value = false;
                            }
                            if(_formKey.currentState!.validate()){
                              final bodyRequest = [
                                {
                                  "genderId":
                                  farmerFamilyMemberCubit.state.genderId,
                                  "nomineeRelationId": farmerFamilyMemberCubit
                                      .state.nomineeRelationId,
                                  "nomineeOccupationId": farmerFamilyMemberCubit
                                      .state.nomineeOccupationId,
                                  "nomineeName":
                                  farmerFamilyMemberCubit.state.nomineeName,
                                  "nomineeAge":
                                  farmerFamilyMemberCubit.state.nomineeAge,
                                  "annualIncome":
                                  farmerFamilyMemberCubit.state.annualIncome
                                }
                              ];
                              context
                                  .read<AddFamilyMemberBloc>()
                                  .add(AddFamilyMember(bodyRequest: bodyRequest));
                            }
                          },
                          child: CommonButton(
                            buttonName: AppLocalizations.of(context)!.save,
                          ),
                        );
                      },
                      listener:
                          (BuildContext context, AddFamilyMemberState state) {
                        if (state is AddFamilyMemberLoading) {
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>  AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              scrollable: true,
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Center(child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  AppTextWidget(text: AppLocalizations.of(context)!.saving,
                                    fontSize: AppTextSize.contentSize20,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),

                            ),
                          );
                        }
                        if( state is AddFamilyMemberSuccess){
                          context.read<GetFarmerFamilyDetailBloc>().add(GetFarmerFamilyDetails());
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        if(state is AddFamilyMemberFail){
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
