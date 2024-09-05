import 'package:ekisan_credit/bloc/bank_type/bank_type_bloc.dart';
import 'package:ekisan_credit/bloc/bank_type/bank_type_state.dart';
import 'package:ekisan_credit/bloc/district/district_state.dart';
import 'package:ekisan_credit/bloc/pacs/pacs_list_state.dart';
import 'package:ekisan_credit/bloc/state/state_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/apply_laon/apply_loan_info_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:ekisan_credit/view/loan_apply/screen/crop_loan_form_crop_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bank_list/bank_list_bloc.dart';
import '../../../bloc/bank_list/bank_list_new.dart';
import '../../../bloc/bank_list/bank_list_state.dart';
import '../../../bloc/bank_type/bank_type_event.dart';
import '../../../bloc/banks_bank_by_type/banks_bank_by_type_bloc.dart';
import '../../../bloc/banks_bank_by_type/banks_bank_by_type_event.dart';
import '../../../bloc/branch/branch_list_bloc.dart';
import '../../../bloc/branch/branch_list_event.dart';
import '../../../bloc/branch/branch_list_state.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/pacs/pacs_list_bloc.dart';
import '../../../bloc/pacs/pacs_list_event.dart';
import '../../../bloc/state/state_bloc.dart';
import '../../../bloc/state/state_event.dart';
import '../../../common_widget/common_type_ahed_widget.dart';
import '../widget/loan_apply_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFormBankDetail extends StatefulWidget {
  static const routeName = "crop-loan-form-bank-details";

  const CropLoanFormBankDetail({super.key});

  @override
  State<CropLoanFormBankDetail> createState() => _CropLoanFormBankDetailState();
}

class _CropLoanFormBankDetailState extends State<CropLoanFormBankDetail> {
  final TextEditingController districtController = TextEditingController();
  final TextEditingController _bankTypeController = TextEditingController();
  final TextEditingController _stateTypeController = TextEditingController();
  final ValueNotifier<bool> _isShowPacs = ValueNotifier<bool>(false);
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _pacsController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read<BankTypeNewBloc>().add(GetALlBankTypeData());
    context.read<StateBloc>().add(GetAllState());
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  final ValueNotifier<bool> _isCovered = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final applyLoanInfoCubit = context.read<ApplyLoanInfoCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LoanApplyHeaderWidget(
                headerName: AppLocalizations.of(context)!.cropLoanForm,
                percentageFirst: 50,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.basicDetails,
                      fontSize: AppTextSize.contentSize24,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextWidget(
                            text: AppLocalizations.of(context)!
                                .weatherCoveredUnderPmjjbyOrPmsbyOrApy,
                            fontWeight: FontWeight.w500,
                            fontSize: AppTextSize.contentSize14,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _isCovered,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return Switch(
                              thumbIcon: thumbIcon,
                              value: _isCovered.value,
                              onChanged: (bool value) {
                                _isCovered.value = !_isCovered.value;
                                if (_isCovered.value) {
                                  applyLoanInfoCubit.updateModel(
                                      covered: "Yes");
                                } else {
                                  applyLoanInfoCubit.updateModel(covered: "No");
                                }
                              },
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    /*******   Bank Type ***********/

                    BlocBuilder<BankTypeNewBloc, BankTypeNewState>(
                      builder: (BuildContext context, BankTypeNewState state) {
                        if (state is GetBankTypeSuccess) {
                          List<String> bankTypeList = state
                                  .getAllBankTypeResponseModel.dataList
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: bankTypeList,
                            suggestionToString: (district) => district,
                            onSelected: (selectedBank) {
                              if (selectedBank.contains('Co-Operative Banks')) {
                                _isShowPacs.value = true;
                              } else {
                                _isShowPacs.value = false;
                              }
                              if (kDebugMode) {
                                print(selectedBank);
                              }
                              _bankTypeController.text = selectedBank;
                              // Handle the selected district logic here
                              final selectedBankObject = state
                                  .getAllBankTypeResponseModel.dataList
                                  ?.firstWhere(
                                      (item) => item.value == selectedBank);
                              final bankRequest = {
                                "type": selectedBankObject?.name
                              };

                              applyLoanInfoCubit.updateModel(
                                  bankType: selectedBankObject?.name);
                              context.read<BanksNewBankByTypeBloc>().add(
                                  GetNewBanksBankByType(
                                      bankRequest: bankRequest));

                              setState(() {
                                _stateTypeController.clear();
                                districtController.clear();
                                _bankController.clear();
                                _branchController.clear();
                                _pacsController.clear();
                              });
                            },
                            controller: _bankTypeController,
                            labelText: AppLocalizations.of(context)!.bankType,
                            hintText:
                                AppLocalizations.of(context)!.someBankType,
                            validator: AppFormValidation.bankType,
                          );
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.bankType,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    /************** State *****************/
                    BlocBuilder<StateBloc, StateState>(
                        builder: (BuildContext context, StateState state) {
                      if (kDebugMode) {
                        print(state);
                      }
                      if (state is GetStateSuccess) {
                        List<String> stateList = state
                                .getAllStateResponseModel.dataList
                                ?.map((item) => item.stateName ?? "")
                                .toList() ??
                            [];

                        return CommonTypeAheadField<String>(
                            suggestions: stateList,
                            suggestionToString: (state) => state,
                            onSelected: (selectedState) {
                              if (kDebugMode) {
                                print(selectedState);
                              }
                              _stateTypeController.text = selectedState;

                              final selectedStateObject = state
                                  .getAllStateResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.stateName == selectedState);
                              applyLoanInfoCubit.updateModel(
                                  stateId: selectedStateObject?.id);
                              final districtRequest = {
                                "stateId": selectedStateObject?.id ?? ''
                              }; // Set the selected value to _selectedState
                              context.read<DistrictBlocNew>().add(
                                  GetAllDistrictByState(
                                      districtRequest: districtRequest));
                              // Handle the selected district logic here
                            },
                            controller: _stateTypeController,
                            labelText: AppLocalizations.of(context)!.state,
                            hintText: AppLocalizations.of(context)!.state,
                            validator: AppFormValidation.validateState);
                      }
                      return CommonTextField(
                        labelText: AppLocalizations.of(context)!.state,
                        enabled: false,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    /************** District *****************/
                    BlocBuilder<DistrictBlocNew, DistrictStateNew>(
                      builder: (BuildContext context, DistrictStateNew state) {
                        if (state is GetDistrictSuccess) {
                          List<String> districtList = state
                                  .getDistrictResponseModel.dataList
                                  ?.map((item) => item.districtName ?? "")
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: districtList,
                            suggestionToString: (district) => district,
                            onSelected: (selectedDistrict) {
                              if (kDebugMode) {
                                print(selectedDistrict);
                              }
                              districtController.text = selectedDistrict;
                              final selectedDistrictObject = state
                                  .getDistrictResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.districtName == selectedDistrict);
                              applyLoanInfoCubit.updateModel(
                                  districtId: selectedDistrictObject?.id);
                              // Handle the selected district logic here

                              final bankRequest = {
                                "type": applyLoanInfoCubit.state.bankType,
                                "stateId": applyLoanInfoCubit.state.stateId,
                                "districtId":
                                    applyLoanInfoCubit.state.districtId,
                              };
                              context.read<GetBankListNewBloc>().add(
                                  GetBanNewBankList(bankRequest: bankRequest));
                              setState(() {
                                _bankController.clear();
                                _branchController.clear();
                                _pacsController.clear();
                              });
                            },
                            controller: districtController,
                            labelText: AppLocalizations.of(context)!.district,
                            hintText:
                                AppLocalizations.of(context)!.selectDistrict,
                            validator: AppFormValidation.validateDistrict,
                          );
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.district,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<GetBankListNewBloc, BankListNewState>(
                      builder: (BuildContext context, BankListNewState state) {
                        if (state is GetBankListNewSuccess) {
                          List<String> bankTypeTypeList = state
                                  .bankListResponseModel.dataList
                                  ?.map((item) =>
                                      item.bankName ??
                                      "") // Specifying that the map returns String
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: bankTypeTypeList,
                            suggestionToString: (bankTypeType) => bankTypeType,
                            onSelected: (selectedBankType) {
                              if (kDebugMode) {
                                print(selectedBankType);
                              }
                              _bankController.text = selectedBankType;
                              final selectedBankObject = state
                                  .bankListResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.bankName == selectedBankType);
                              applyLoanInfoCubit.updateModel(
                                  bankMasterId: selectedBankObject?.id);
                              final branchListRequest = {
                                "stateId": applyLoanInfoCubit.state.stateId,
                                "districtId":
                                    applyLoanInfoCubit.state.districtId,
                                "bankMasterId": selectedBankObject?.id
                              };
                              setState(() {
                                _branchController.clear();
                                _pacsController.clear();
                              });
                              context.read<BranchListNewBloc>().add(
                                  GetNewBranchList(
                                      branchListRequest: branchListRequest));
                            },
                            controller: _bankController,
                            labelText: AppLocalizations.of(context)!.bank,
                            hintText: AppLocalizations.of(context)!.selectBank,
                            validator: AppFormValidation.bank,
                          );
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.bank,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<BranchListNewBloc, BranchListNewState>(
                      builder:
                          (BuildContext context, BranchListNewState state) {
                        if (state is GetNewBranchListSuccess) {
                          List<String> bankTypeTypeList = state
                                  .branchListResponseModel.dataList
                                  ?.map((item) =>
                                      item.entityLevelName ??
                                      "") // Specifying that the map returns String
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: bankTypeTypeList,
                            suggestionToString: (bankTypeType) => bankTypeType,
                            onSelected: (selectedBranchType) {
                              if (kDebugMode) {
                                print(selectedBranchType);
                              }
                              _branchController.text = selectedBranchType;
                              final selectedBranchObject = state
                                  .branchListResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.entityLevelName ==
                                      selectedBranchType);

                              applyLoanInfoCubit.updateModel(
                                  branchId: selectedBranchObject?.id);
                              final branchListRequest = {
                                "entityLevelId": selectedBranchObject?.id
                              };
                              setState(() {
                                _pacsController.clear();
                              });
                              context.read<PacsListNewBloc>().add(
                                  GetPacsListNew(
                                      branchListRequest: branchListRequest));
                            },
                            controller: _branchController,
                            labelText: AppLocalizations.of(context)!.branch,
                            hintText:
                                AppLocalizations.of(context)!.selectBranch,
                            validator: AppFormValidation.validateBranch,
                          );
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.branch,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isShowPacs,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return value
                            ? BlocBuilder<PacsListNewBloc, PacsListNewState>(
                                builder: (BuildContext context,
                                    PacsListNewState state) {
                                  if (state is GetPacsListNewSuccess) {
                                    List<String> pacsList = state
                                            .pacsListNewResponseModel.dataList
                                            ?.map((item) =>
                                                item.entityLevelName ??
                                                "") // Specifying that the map returns String
                                            .toList() ??
                                        [];
                                    return CommonTypeAheadField<String>(
                                      suggestions: pacsList,
                                      suggestionToString: (pacsData) =>
                                          pacsData,
                                      onSelected: (selectedPacs) {
                                        _pacsController.text = selectedPacs;

                                        final selectedPacsObject = state
                                            .pacsListNewResponseModel.dataList
                                            ?.firstWhere((item) =>
                                                item.entityLevelName ==
                                                selectedPacs);

                                        applyLoanInfoCubit.updateModel(
                                            pacsLevelId:
                                                selectedPacsObject?.id);
                                      },
                                      controller: _pacsController,
                                      labelText:
                                          AppLocalizations.of(context)!.pacs,
                                      hintText: AppLocalizations.of(context)!
                                          .selectPacs,
                                      validator: AppFormValidation.validatePacs,
                                    );
                                  }
                                  return CommonTextField(
                                    labelText:
                                        AppLocalizations.of(context)!.pacs,
                                    enabled: false,
                                  );
                                },
                              )
                            : Container();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_isShowPacs.value) {
                      applyLoanInfoCubit.updateModel(pacsLevelId: null);
                    }

                    Navigator.pushNamed(
                        context, CropLoanFromCropDetailsScreen.routeName);
                  }
                },
                child: CommonButton(
                  buttonName: AppLocalizations.of(context)!.next,
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
