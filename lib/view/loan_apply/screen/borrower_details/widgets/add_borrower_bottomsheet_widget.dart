import 'package:ekisan_credit/cubit/model/other_details_cubit_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../bloc/bank_type/bank_type_bloc.dart';
import '../../../../../bloc/bank_type/bank_type_state.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_text_field_widget.dart';
import '../../../../../common_widget/common_type_ahed_widget.dart';
import '../../../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../model/response/lovtype_type_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/text_input_formate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBorrowerBottomSheetWidget extends StatefulWidget {
  const AddBorrowerBottomSheetWidget({super.key});

  @override
  State<AddBorrowerBottomSheetWidget> createState() =>
      _AddGuaratorBottomSheetWidgetState();
}

class _AddGuaratorBottomSheetWidgetState
    extends State<AddBorrowerBottomSheetWidget> {
  TextEditingController dateController = TextEditingController();
  final ValueNotifier<bool> _isAccountStatusFilled = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isAssetFilled = ValueNotifier<bool>(false);

  final _bankTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    // final applyLoanInfoCubit = context.read<ApplyLoanInfoCubit>();
    final otherDetailsCubit = context.read<OtherDetailsCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 16,
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
              height: 28,
            ),
            AppTextWidget(
              text: AppLocalizations.of(context)!.borrowerAccount,
              fontWeight: FontWeight.w400,
              fontSize: AppTextSize.contentSize22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  /************** BankType *****************/
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
                            if (kDebugMode) {
                              print(selectedBank);
                            }
                            _bankTypeController.text = selectedBank;

                            // Handle the selected district logic here
                            final selectedBankObject = state
                                .getAllBankTypeResponseModel.dataList
                                ?.firstWhere(
                                    (item) => item.value == selectedBank);

                            context.read<OtherDetailsCubit>().addDataFromUI(
                                  userLoanLiability: UserLoanLiabilitiesList(
                                      bankType: selectedBankObject?.name),
                                );
                            // final bankRequest = {
                            //   "type": selectedBankObject?.name
                            // };
                            // applyLoanInfoCubit.updateModel(
                            //     bankType: selectedBankObject?.name);
                            // context.read<BanksNewBankByTypeBloc>().add(
                            //     GetNewBanksBankByType(
                            //         bankRequest: bankRequest));
                          },
                          controller: _bankTypeController,
                          labelText: AppLocalizations.of(context)!
                              .typeOfInstitutionBank,
                          hintText: AppLocalizations.of(context)!.someBankType,
                        );
                      }
                      return CommonTextField(
                        labelText:
                            AppLocalizations.of(context)!.typeOfInstitutionBank,
                        enabled: false,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText:
                        AppLocalizations.of(context)!.nameOfInstitutionBank,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            userLoanLiability:
                                UserLoanLiabilitiesList(bankName: value),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.branchName,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            userLoanLiability:
                                UserLoanLiabilitiesList(branchName: value),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.loanPurpose,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            userLoanLiability:
                                UserLoanLiabilitiesList(loanPurpose: value),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.balanceOutStanding,
                    prefixIcon: Icons.currency_rupee,
                    showPrefixIcon: true,
                    length: 20,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            userLoanLiability:
                                UserLoanLiabilitiesList(outstanding: value),
                          );
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                    builder:
                        (BuildContext context, GetLovsTypeDataNewState state) {
                      if (state is GetLovsTypeDataSuccess) {
                        List<LovTypeDataList>? accountStatusList = state
                            .lovsTypeResponseModel.dataList
                            ?.where((item) => item.lovType == "ACCOUNTSTATUS")
                            .toList();

                        // Extracting the gender values from the filtered list
                        List<String> accountStatus = accountStatusList
                                ?.map((item) => item.value ?? "")
                                .toList() ??
                            [];

                        // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                        return ValueListenableBuilder(
                          valueListenable: _isAccountStatusFilled,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Column(
                              children: [
                                TwoAndThreeDividedHeaders(
                                  padding: EdgeInsets.zero,
                                  title: AppLocalizations.of(context)!
                                      .statusOfAccount,
                                  contentList: accountStatus,
                                  showError: value,
                                  onValueSelected:
                                      (String selectedAccountStatus) {
                                    // Filter naming titles list based on selected gender
                                    List<LovTypeDataList>? accountStatusList =
                                        state
                                            .lovsTypeResponseModel.dataList
                                            ?.where((item) =>
                                                item.lovType ==
                                                    "ACCOUNTSTATUS" &&
                                                item.value ==
                                                    selectedAccountStatus)
                                            .toList();

                                    // Print the id of the first item found
                                    if (accountStatusList != null &&
                                        accountStatusList.isNotEmpty) {
                                      context
                                          .read<OtherDetailsCubit>()
                                          .addDataFromUI(
                                            userLoanLiability:
                                                UserLoanLiabilitiesList(
                                                    accountStatusId:
                                                        accountStatusList[0]
                                                            .id
                                                            .toString()),
                                          );
                                      if (kDebugMode) {
                                        print(
                                            "Selected Account Status: $selectedAccountStatus, Corresponding ID: ${accountStatusList[0].id}");
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print(
                                            "No naming title found for selected account: $selectedAccountStatus");
                                      }
                                    }
                                    if (kDebugMode) {
                                      print(
                                          "Selected Account Status: $selectedAccountStatus");
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
                                                .pleaseSelectStatusOfAccount,
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                    builder:
                        (BuildContext context, GetLovsTypeDataNewState state) {
                      if (state is GetLovsTypeDataSuccess) {
                        List<LovTypeDataList>? accountStatusList = state
                            .lovsTypeResponseModel.dataList
                            ?.where((item) => item.lovType == "SECURITYOFFERED")
                            .toList();

                        // Extracting the gender values from the filtered list
                        List<String> accountStatus = accountStatusList
                                ?.map((item) => item.value ?? "")
                                .toList() ??
                            [];

                        // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                        return ValueListenableBuilder(
                          valueListenable: _isAssetFilled,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Column(
                              children: [
                                TwoAndThreeDividedHeaders(
                                  padding: EdgeInsets.zero,
                                  title: AppLocalizations.of(context)!
                                      .securityOfferedAsset,
                                  contentList: accountStatus,
                                  showError: value,
                                  onValueSelected:
                                      (String selectedSecurityOffered) {
                                    // Filter naming titles list based on selected gender
                                    List<LovTypeDataList>? securityOfferedList =
                                        state.lovsTypeResponseModel.dataList
                                            ?.where((item) =>
                                                item.lovType ==
                                                    "SECURITYOFFERED" &&
                                                item.value ==
                                                    selectedSecurityOffered)
                                            .toList();

                                    // Print the id of the first item found
                                    if (securityOfferedList != null &&
                                        securityOfferedList.isNotEmpty) {
                                      context
                                          .read<OtherDetailsCubit>()
                                          .addDataFromUI(
                                            userLoanLiability:
                                                UserLoanLiabilitiesList(
                                                    securityOfferedId:
                                                        securityOfferedList[0]
                                                            .id
                                                            .toString()),
                                          );
                                      if (kDebugMode) {
                                        print(
                                            "Selected security : $selectedSecurityOffered, Corresponding ID: ${securityOfferedList[0].id}");
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print(
                                            "No naming title found for selected security : $selectedSecurityOffered");
                                      }
                                    }
                                    if (kDebugMode) {
                                      print(
                                          "Selected security offered: $selectedSecurityOffered");
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.cancel,
                              borderColor: AppColors.greenColor,
                              buttonColor: Colors.transparent,
                              buttonTextColor: AppColors.greenColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child:
                              BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
                            builder: (BuildContext context,
                                OtherDetailsState state) {
                              if (state.userLoanLiability?.accountStatusId !=
                                      null &&
                                  state.userLoanLiability?.securityOfferedId !=
                                      null &&
                                  state.userLoanLiability?.bankName != null &&
                                  state.userLoanLiability?.bankType != null &&
                                  state.userLoanLiability?.branchName != null &&
                                  state.userLoanLiability?.loanPurpose !=
                                      null &&
                                  state.userLoanLiability?.outstanding !=
                                      null) {
                                return InkWell(
                                  onTap: () {
                                    otherDetailsCubit.addBorrowerList(
                                      UserLoanLiabilitiesList(
                                        farmerId: otherDetailsCubit
                                            .state.userLoanLiability?.farmerId,
                                        accountStatusId: otherDetailsCubit.state
                                            .userLoanLiability?.accountStatusId,
                                        securityOfferedId: otherDetailsCubit
                                            .state
                                            .userLoanLiability
                                            ?.securityOfferedId,
                                        bankName: otherDetailsCubit
                                            .state.userLoanLiability?.bankName,
                                        branchName: otherDetailsCubit.state
                                            .userLoanLiability?.branchName,
                                        loanPurpose: otherDetailsCubit.state
                                            .userLoanLiability?.loanPurpose,
                                        outstanding: otherDetailsCubit.state
                                            .userLoanLiability?.outstanding,
                                        bankType: otherDetailsCubit
                                            .state.userLoanLiability?.bankType,
                                        listId: uuid.v4(),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: CommonButton(
                                    buttonName:
                                        AppLocalizations.of(context)!.save,
                                  ),
                                );
                              }

                              return CommonButton(
                                buttonName: AppLocalizations.of(context)!.save,
                                buttonColor: AppColors.grayColor,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
