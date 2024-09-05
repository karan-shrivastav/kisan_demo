import 'package:ekisan_credit/utils/text_input_formate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import '../../../cubit/model/farmer_family_member_cubit_model.dart';
import '../../../utils/form_validation.dart';
import '../../family/widgets/farmer_family_occupation_widget.dart';
import '../../family/widgets/gender_widget.dart';
import '../../profile/widgets/select_releation_widget.dart';

class AddFamilyBottomSheetWidget extends StatefulWidget {
  const AddFamilyBottomSheetWidget({super.key});

  @override
  State<AddFamilyBottomSheetWidget> createState() =>
      _AddFamilyBottomSheetWidgetState();
}

class _AddFamilyBottomSheetWidgetState
    extends State<AddFamilyBottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);

  @override
  void initState() {
    context.read<FarmerFamilyMemberCubit>().clear();
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
    super.initState();
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
                  text: AppLocalizations.of(context)!.addFamilyInformation,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CommonTextField(
                          labelText: AppLocalizations.of(context)!.fullName,
                          hintText: AppLocalizations.of(context)!.asPerAadhaar,
                          vertical: 20,
                          validator: (value) =>
                              AppFormValidation.validateName(context, value),
                          onChange: (value) {
                            farmerFamilyMemberCubit.updateModel(
                                nomineeName: value);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonTextField(
                        length: 2,
                        labelText: AppLocalizations.of(context)!.age,
                        hintText: AppLocalizations.of(context)!.age,
                        validator: AppFormValidation.validateAge,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        vertical: 20,
                        onChange: (value) {
                          farmerFamilyMemberCubit.updateModel(
                              nomineeAge: value);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const GenderWidget(),
                      const SizedBox(
                        height: 20,
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
                        length: 11,
                        showPrefixIcon: true,
                        prefixIcon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                        labelText: AppLocalizations.of(context)!.annualIncome,
                        hintText: AppLocalizations.of(context)!.annualIncome,
                        vertical: 20,
                        validator: AppFormValidation.validateIncome,
                        onChange: (value) {
                          farmerFamilyMemberCubit.updateModel(
                              annualIncome: value);
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
                                buttonName:
                                    AppLocalizations.of(context)!.cancell,
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
                                    state.nomineeRelationId != null &&
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final bodyRequest = [
                                              {
                                                "genderId":
                                                    farmerFamilyMemberCubit
                                                        .state.genderId,
                                                "nomineeRelationId":
                                                    farmerFamilyMemberCubit
                                                        .state
                                                        .nomineeRelationId,
                                                "nomineeOccupationId":
                                                    farmerFamilyMemberCubit
                                                        .state
                                                        .nomineeOccupationId,
                                                "nomineeName":
                                                    farmerFamilyMemberCubit
                                                        .state.nomineeName,
                                                "nomineeAge":
                                                    farmerFamilyMemberCubit
                                                        .state.nomineeAge,
                                                "annualIncome":
                                                    farmerFamilyMemberCubit
                                                        .state.annualIncome
                                              }
                                            ];
                                            context
                                                .read<AddFamilyMemberBloc>()
                                                .add(AddFamilyMember(
                                                    bodyRequest: bodyRequest));
                                          }
                                        },
                                        child: CommonButton(
                                          buttonName:
                                              AppLocalizations.of(context)!
                                                  .save,
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
                                                  text: AppLocalizations.of(
                                                          context)!
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
                                        context
                                            .read<GetFarmerFamilyDetailBloc>()
                                            .add(GetFarmerFamilyDetails());
                                        farmerFamilyMemberCubit.updateModel(
                                          genderId: null,
                                          nomineeRelationId: null,
                                          nomineeOccupationId: null,
                                          nomineeName: "",
                                          nomineeAge: "",
                                          annualIncome: "",
                                        );
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
                                  buttonName:
                                      AppLocalizations.of(context)!.save,
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
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
