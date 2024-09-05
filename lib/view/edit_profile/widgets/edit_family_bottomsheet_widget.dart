import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_text_field_widget.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../bloc/family/add_family_member_bloc.dart';
import '../../../bloc/family/add_family_member_event.dart';
import '../../../bloc/family/add_family_member_state.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import '../../../cubit/model/farmer_family_member_cubit_model.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/form_validation.dart';
import '../../../utils/text_input_formate.dart';
import 'edit_select_relation_widget.dart';

class EditFamilyBottomSheetWidget extends StatefulWidget {
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
  EditFamilyBottomSheetWidget({
    super.key,
    this.id,
    this.genderId,
    this.nomineeRelationId,
    this.occupationId,
    this.gender,
    this.fullNameController,
    this.ageController,
    this.relationTextEditingController,
    this.occupationTextEditingController,
    this.annualIncomeController,
  });

  @override
  State<EditFamilyBottomSheetWidget> createState() =>
      _EditFamilyBottomSheetWidgetState();
}

class _EditFamilyBottomSheetWidgetState
    extends State<EditFamilyBottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _relationController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _annualIncomController = TextEditingController();

  @override
  void initState() {
    _nameController = widget.fullNameController ?? TextEditingController();
    _ageController = widget.ageController ?? TextEditingController();
    _relationController =
        widget.relationTextEditingController ?? TextEditingController();
    _occupationController =
        widget.occupationTextEditingController ?? TextEditingController();
    _annualIncomController =
        widget.annualIncomeController ?? TextEditingController();
    context.read<FarmerFamilyMemberCubit>().updateModel(
          nomineeName: widget.fullNameController?.text,
          nomineeAge: widget.ageController?.text,
          nomineeRelationId: widget.nomineeRelationId,
          genderId: widget.genderId,
          nomineeOccupationId: widget.occupationId,
          annualIncome: widget.annualIncomeController?.text,
        );
    final lovsTypeData = [
      "ASSESTNAME",
      "ASSESTTYPE",
      "AREAUNIT",
      "OWNERSHIP",
      "SOURCEIRRIGATIONNAME",
      "GENDER",
      "NAMINGTITLE",
      "IDPROOF",
      "RELIGIONNAME",
      "CASTE",
      "OCCUPATION"
    ];
    context.read<GetLovsTypeDataNewBloc>().add(GetLovsTypeDataNewList(
          bodyRequest: lovsTypeData,
        ));

    context
        .read<RelationshipDataBloc>()
        .add(GetRelationshipList(bodyRequest: ['${widget.genderId}']));
    super.initState();
  }

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final farmerFamilyMemberCubit = context.read<FarmerFamilyMemberCubit>();
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.secondOutLineColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.updateFamilyInformation,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                      controller: _nameController,
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
                    length: 2,
                    controller: _ageController,
                    labelText: AppLocalizations.of(context)!.age,
                    hintText: AppLocalizations.of(context)!.age,
                    validator: AppFormValidation.validateAge,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    vertical: 20,
                    onChange: (value) {
                      farmerFamilyMemberCubit.updateModel(nomineeAge: value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                    builder:
                        (BuildContext context, GetLovsTypeDataNewState state) {
                      if (state is GetLovsTypeDataSuccess) {
                        List<LovTypeDataList>? genderList = state
                            .lovsTypeResponseModel.dataList
                            ?.where((item) => item.lovType == "GENDER")
                            .toList();

                        // Extracting the gender values from the filtered list
                        List<String> namingValue = genderList
                                ?.map((item) => item.value ?? "")
                                .toList() ??
                            [];

                        // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                        return ValueListenableBuilder(
                          valueListenable: _isGenderFilled,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Column(
                              children: [
                                TwoAndThreeDividedHeaders(
                                  padding: EdgeInsets.zero,
                                  heightBetweenContentAndTitle: 15,
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
                                      if (farmerFamilyMemberCubit
                                              .state.genderId ==
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
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
                    listener: (BuildContext context,
                        GetLovsTypeDataNewState state) {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  EditSelectRelationWidget(
                    relationTextEditingController: _relationController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                    builder:
                        (BuildContext context, GetLovsTypeDataNewState state) {
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
                          controller: _occupationController,
                          suggestionsCallback: (pattern) {
                            return getSuggestions(pattern, idProofValues);
                          },
                          builder: (context, controller, focusNode) {
                            return TextFormField(
                              controller: controller,
                              validator: AppFormValidation.validateOccupation,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.outLineColor),
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .selectOccupation,
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: AppColors.textBlackColor),
                                  suffixIcon:
                                      const Icon(Icons.arrow_drop_down)),
                            );
                          },
                          itemBuilder: (context, idProof) {
                            return ListTile(
                              title: Text(idProof),
                            );
                          },
                          onSelected: (selectedIdProof) {
                            _occupationController.text = selectedIdProof;

                            List<LovTypeDataList>? occupationTypeList = state
                                .lovsTypeResponseModel.dataList
                                ?.where((item) =>
                                    item.lovType == "OCCUPATION" &&
                                    item.value == selectedIdProof)
                                .toList();

                            // Print the id of the first item found
                            if (occupationTypeList != null &&
                                occupationTypeList.isNotEmpty) {
                              context
                                  .read<FarmerFamilyMemberCubit>()
                                  .updateModel(
                                      nomineeOccupationId:
                                          occupationTypeList[0].id);
                              if (kDebugMode) {
                                print(
                                    "Corresponding ID: ${occupationTypeList[0].id}");
                              }
                            }
                          },
                        );
                      }
                      return CommonTextField(
                          enabled: false,
                          suffixIcon: Icons.arrow_drop_down,
                          labelText: AppLocalizations.of(context)!.occupation);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    controller: _annualIncomController,
                    showPrefixIcon: true,
                    length: 11,
                    prefixIcon: Icons.currency_rupee,
                    labelText: AppLocalizations.of(context)!.annualIncome,
                    hintText: AppLocalizations.of(context)!.annualIncome,
                    vertical: 20,
                    validator: AppFormValidation.validateIncome,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
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
                        child: BlocConsumer<FarmerFamilyMemberCubit,
                            FarmerFamilyMemberCubitModel>(
                          builder: (BuildContext context,
                              FarmerFamilyMemberCubitModel state) {
                            if (state.nomineeName != "" &&
                                state.nomineeAge != "" &&
                                state.genderId != null &&
                                state.nomineeOccupationId != null &&
                                state.annualIncome != "" &&
                                state.annualIncome != null &&
                                state.relationName != "" &&
                                state.relationName != null) {
                              return BlocConsumer<AddFamilyMemberBloc,
                                  AddFamilyMemberState>(
                                builder: (BuildContext context,
                                    AddFamilyMemberState state) {
                                  return InkWell(
                                    onTap: () {
                                      if (farmerFamilyMemberCubit
                                              .state.genderId ==
                                          null) {
                                        _isGenderFilled.value = true;
                                      } else {
                                        _isGenderFilled.value = false;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        final bodyRequest = [
                                          {
                                            "id": widget.id,
                                            "genderId": farmerFamilyMemberCubit
                                                    .state.genderId ??
                                                widget.genderId,
                                            "nomineeRelationId":
                                                farmerFamilyMemberCubit.state
                                                        .nomineeRelationId ??
                                                    widget.nomineeRelationId,
                                            "nomineeOccupationId":
                                                farmerFamilyMemberCubit.state
                                                        .nomineeOccupationId ??
                                                    widget.occupationId,
                                            "nomineeName":
                                                farmerFamilyMemberCubit
                                                        .state.nomineeName ??
                                                    widget.fullNameController
                                                        ?.text,
                                            "nomineeAge":
                                                farmerFamilyMemberCubit
                                                        .state.nomineeAge ??
                                                    widget.ageController?.text,
                                            "annualIncome":
                                                farmerFamilyMemberCubit
                                                        .state.annualIncome ??
                                                    widget
                                                        .annualIncomeController
                                                        ?.text,
                                          }
                                        ];
                                        if (kDebugMode) {
                                          print(
                                              '###################################');
                                        }
                                        if (kDebugMode) {
                                          print(bodyRequest);
                                        }
                                        if (kDebugMode) {
                                          print(
                                              '###################################');
                                        }

                                        context.read<AddFamilyMemberBloc>().add(
                                            AddFamilyMember(
                                                bodyRequest: bodyRequest));
                                      }
                                    },
                                    child: CommonButton(
                                      buttonName:
                                          AppLocalizations.of(context)!.update,
                                    ),
                                  );
                                },
                                listener: (BuildContext context,
                                    AddFamilyMemberState state) {
                                  if (state is AddFamilyMemberLoading) {
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
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
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                            ),
                                            AppTextWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .saving,
                                              fontSize:
                                                  AppTextSize.contentSize20,
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
                                        .read<GetFarmerFamilyDetailBloc>()
                                        .add(GetFarmerFamilyDetails());
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                  if (state is AddFamilyMemberFail) {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            }
                            return CommonButton(
                              buttonName: AppLocalizations.of(context)!.update,
                              buttonColor: AppColors.grayColor,
                            );
                          },
                          listener: (BuildContext context,
                              FarmerFamilyMemberCubitModel state) {},
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
