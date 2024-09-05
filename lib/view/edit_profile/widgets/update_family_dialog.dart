import 'package:ekisan_credit/bloc/family/add_family_member_bloc.dart';
import 'package:ekisan_credit/bloc/family/add_family_member_event.dart';
import 'package:ekisan_credit/cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/family/add_family_member_state.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
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
import 'edit_select_relation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateFamilyDialog extends StatefulWidget {
  int? id;
  int? genderId;
  int? nomineeRelationId;
  int? occupationId;
  final String? gender;
  final TextEditingController? fullNameController;
  final TextEditingController? ageController;
  final TextEditingController? annualIncomeController;
  final TextEditingController? relationTextEditingController;
  final TextEditingController? occupationTextEditingController;

  UpdateFamilyDialog({
    super.key,
    this.id,
    this.genderId,
    this.nomineeRelationId,
    this.occupationId,
    this.gender,
    this.fullNameController,
    this.ageController,
    this.relationTextEditingController,
    this.annualIncomeController,
    this.occupationTextEditingController,
  });

  @override
  State<UpdateFamilyDialog> createState() => _UpdateFamilyDialogState();
}

class _UpdateFamilyDialogState extends State<UpdateFamilyDialog> {
  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final farmerFamilyMemberCubit = context.read<FarmerFamilyMemberCubit>();
    return AppAlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextWidget(
                text: AppLocalizations.of(context)!.updateFamilyInformation,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 16,
              ),
              CommonTextField(
                  controller: widget.fullNameController,
                  labelText: AppLocalizations.of(context)!.fullName,
                  hintText: AppLocalizations.of(context)!.asPerAadhaar,
                  vertical: 20,
                  validator: (value) =>
                      AppFormValidation.validateName(context, value),
                  onChange: (value) {
                    farmerFamilyMemberCubit.updateModel(nomineeName: value);
                  }),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(
                controller: widget.ageController,
                labelText: AppLocalizations.of(context)!.age,
                hintText: AppLocalizations.of(context)!.age,
                validator: AppFormValidation.validateAge,
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
                              savedSelectedValue: widget.gender,
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
                                if (genderList != null &&
                                    genderList.isNotEmpty) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 16),
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
                listener:
                    (BuildContext context, GetLovsTypeDataNewState state) {},
              ),
              const SizedBox(
                height: 10,
              ),
              EditSelectRelationWidget(
                relationTextEditingController:
                    widget.relationTextEditingController ??
                        TextEditingController(),
              ),
              const SizedBox(
                height: 10,
              ),
              // EditFarmerFamilyOccupationWidget(
              //   selectOccupationTextEditingController:
              //       occupationTextEditingController ?? TextEditingController(),
              // ),

              BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                builder: (BuildContext context, GetLovsTypeDataNewState state) {
                  if (state is GetLovsTypeDataSuccess) {
                    List<LovTypeDataList>? religionTypeList = state
                        .lovsTypeResponseModel.dataList
                        ?.where((item) => item.lovType == "OCCUPATION")
                        .toList();

                    // Extracting the identity type values from the filtered list
                    List<String> idProofValues = religionTypeList
                            ?.map((item) => item.value ?? "")
                            .toList() ??
                        [];

                    return TypeAheadField<String>(
                      controller: widget.occupationTextEditingController,
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
                              borderSide:
                                  BorderSide(color: AppColors.outLineColor),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.selectOccupation,
                            labelStyle:
                                const TextStyle(color: AppColors.outLineColor),
                          ),
                        );
                      },
                      itemBuilder: (context, idProof) {
                        return ListTile(
                          title: Text(idProof),
                        );
                      },
                      onSelected: (selectedIdProof) {
                        widget.occupationTextEditingController?.text =
                            selectedIdProof;

                        List<LovTypeDataList>? occupationTypeList = state
                            .lovsTypeResponseModel.dataList
                            ?.where((item) =>
                                item.lovType == "OCCUPATION" &&
                                item.value == selectedIdProof)
                            .toList();

                        // Print the id of the first item found
                        if (occupationTypeList != null &&
                            occupationTypeList.isNotEmpty) {
                          context.read<FarmerFamilyMemberCubit>().updateModel(
                              nomineeOccupationId: occupationTypeList[0].id);
                          if (kDebugMode) {
                            print(
                                "Corresponding ID: ${occupationTypeList[0].id}");
                          }
                        }
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 10,
              ),

              CommonTextField(
                controller:
                    widget.annualIncomeController ?? TextEditingController(),
                showPrefixIcon: true,
                prefixIcon: Icons.currency_rupee,
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
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.cancel,
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
                            if (_formKey.currentState!.validate()) {
                              final bodyRequest = [
                                {
                                  "id": widget.id,
                                  "genderId":
                                      farmerFamilyMemberCubit.state.genderId ??
                                          widget.genderId,
                                  "nomineeRelationId": farmerFamilyMemberCubit
                                          .state.nomineeRelationId ??
                                      widget.nomineeRelationId,
                                  "nomineeOccupationId": farmerFamilyMemberCubit
                                          .state.nomineeOccupationId ??
                                      widget.occupationId,
                                  "nomineeName": farmerFamilyMemberCubit
                                          .state.nomineeName ??
                                      widget.fullNameController?.text,
                                  "nomineeAge": farmerFamilyMemberCubit
                                          .state.nomineeAge ??
                                      widget.ageController?.text,
                                  "annualIncome": farmerFamilyMemberCubit
                                          .state.annualIncome ??
                                      widget.annualIncomeController?.text,
                                }
                              ];
                              if (kDebugMode) {
                                print('###################################');
                              }
                              if (kDebugMode) {
                                print('###################################');
                              }
                              if (kDebugMode) {
                                print(bodyRequest);
                              }
                              if (kDebugMode) {
                                print('###################################');
                              }
                              if (kDebugMode) {
                                print('###################################');
                              }

                              context.read<AddFamilyMemberBloc>().add(
                                  AddFamilyMember(bodyRequest: bodyRequest));
                            }
                          },
                          child: CommonButton(
                            buttonName: AppLocalizations.of(context)!.update,
                          ),
                        );
                      },
                      listener:
                          (BuildContext context, AddFamilyMemberState state) {
                        if (state is AddFamilyMemberLoading) {
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
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
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!.saving,
                                    fontSize: AppTextSize.contentSize20,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is AddFamilyMemberSuccess) {
                          setState(() {
                            widget.id = null;
                            widget.genderId = null;
                            widget.nomineeRelationId = null;
                            widget.occupationId = null;
                            widget.fullNameController?.clear();
                            widget.ageController?.clear();
                            widget.annualIncomeController?.clear();
                          });
                          context
                              .read<GetFarmerBloc>()
                              .add(GetFarmerDetails(body: const {}));
                          context
                              .read<GetFarmerFamilyDetailBloc>()
                              .add(GetFarmerFamilyDetails());
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                        if (state is AddFamilyMemberFail) {
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
