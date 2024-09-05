import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../bloc/bank_type/bank_type_bloc.dart';
import '../../../../../bloc/bank_type/bank_type_state.dart';
import '../../../../../bloc/banks_bank_by_type/banks_bank_by_type_bloc.dart';
import '../../../../../bloc/banks_bank_by_type/banks_bank_by_type_event.dart';
import '../../../../../bloc/banks_bank_by_type/banks_bank_by_type_state.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_text_field_widget.dart';
import '../../../../../common_widget/common_type_ahed_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../cubit/model/other_details_cubit_model.dart';
import '../../../../../model/response/lovtype_type_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/form_validation.dart';
import '../../../../../utils/text_input_formate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LiabilitiesGuarantorBottomSheetWidget extends StatefulWidget {
  const LiabilitiesGuarantorBottomSheetWidget({super.key});

  @override
  State<LiabilitiesGuarantorBottomSheetWidget> createState() =>
      _LiabilitiesGuarantorBottomSheetWidgetState();
}

class _LiabilitiesGuarantorBottomSheetWidgetState
    extends State<LiabilitiesGuarantorBottomSheetWidget> {
  final TextEditingController _statusOfAccountController =
      TextEditingController();
  TextEditingController dateController = TextEditingController();
  final ValueNotifier<bool> _isAccountStatusFilled = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isAssetFilled = ValueNotifier<bool>(false);

  final _bankTypeController = TextEditingController();
  final _nameofBankInstitutionTextEditingController = TextEditingController();
  var uuid = const Uuid();

  @override
  void initState() {
    context.read<OtherDetailsCubit>().clearLiabilitiesLoanGuarantor();
    final lovTypeData = ['ACCOUNTSTATUS', 'SECURITYOFFERED'];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovTypeData,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              text: AppLocalizations.of(context)!.addLiabilitiesAsGuarantor,
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
                  CommonTextField(
                    labelText:AppLocalizations.of(context)!.borrowerName,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanLiabilityGuarantor: LoanLiabilityGuarantor(
                              guarantorName: value,
                            ),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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

                            final bankRequest = {
                              "type": selectedBankObject?.name
                            };
                            context.read<BanksNewBankByTypeBloc>().add(
                                GetNewBanksBankByType(
                                    bankRequest: bankRequest));
                          },
                          controller: _bankTypeController,
                          labelText: AppLocalizations.of(context)!.instituteType,
                          hintText: AppLocalizations.of(context)!.someBankType,
                        );
                      }
                      return  CommonTextField(
                        labelText: AppLocalizations.of(context)!.typeOfInstitutionBank,
                        enabled: false,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<BanksNewBankByTypeBloc, BanksNewBankByTypeState>(
                    builder:
                        (BuildContext context, BanksNewBankByTypeState state) {
                      if (state is BanksNewBankByTypeSuccess) {
                        List<String> bankTypeList = state
                                .getBanksTypeTypeResponseModel.dataList
                                ?.map((item) => item.bankName ?? "")
                                .toList() ??
                            [];
                        return CommonTypeAheadField<String>(
                          suggestions: bankTypeList,
                          suggestionToString: (district) => district,
                          onSelected: (selectedBank) {
                            if (kDebugMode) {
                              print(selectedBank);
                            }
                            _nameofBankInstitutionTextEditingController.text =
                                selectedBank;

                            // Handle the selected district logic here
                            final selectedBankObject = state
                                .getBanksTypeTypeResponseModel.dataList
                                ?.firstWhere(
                                    (item) => item.bankName == selectedBank);

                            context.read<OtherDetailsCubit>().addDataFromUI(
                                  loanLiabilityGuarantor:
                                      LoanLiabilityGuarantor(
                                    bankName: selectedBankObject?.bankName,
                                    bankMasterId:
                                        selectedBankObject?.id.toString(),
                                  ),
                                );

                            // final bankRequest = {
                            //   "type": selectedBankObject?.name
                            // };
                            // context.read<BanksNewBankByTypeBloc>().add(
                            //     GetNewBanksBankByType(
                            //         bankRequest: bankRequest));
                          },
                          controller:
                              _nameofBankInstitutionTextEditingController,
                          labelText: AppLocalizations.of(context)!.nameOfBankInstitution,
                          hintText: AppLocalizations.of(context)!.someBankType,
                        );
                      }
                      return  CommonTextField(
                        labelText: AppLocalizations.of(context)!.nameOfBankInstitution,
                        enabled: false,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.loanAmount,
                    prefixIcon: Icons.currency_rupee,
                    showPrefixIcon: true,
                    keyboardType: TextInputType.number,
                    length: 20,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanLiabilityGuarantor: LoanLiabilityGuarantor(
                              loanAmount: value,
                            ),
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
                    keyboardType: TextInputType.number,
                    length: 20,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanLiabilityGuarantor: LoanLiabilityGuarantor(
                              outstanding: value,
                            ),
                          );
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
                            ?.where((item) => item.lovType == "ACCOUNTSTATUS")
                            .toList();

                        // Extracting the gender values from the filtered list
                        List<String> accountStatus = accountStatusList
                                ?.map((item) => item.value ?? "")
                                .toList() ??
                            [];

                        // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                        return CommonTypeAheadField<String>(
                          suggestions: accountStatus,
                          suggestionToString: (accountStatus) => accountStatus,
                          controller: _statusOfAccountController,
                          labelText: AppLocalizations.of(context)!.statusOfAccount,
                          hintText: AppLocalizations.of(context)!.statusOfAccount,
                          onSelected: (String selectedAccountStatus) {
                            _statusOfAccountController.text =
                                selectedAccountStatus;
                            // Filter naming titles list based on selected gender
                            List<LovTypeDataList>? accountStatusList = state
                                .lovsTypeResponseModel.dataList
                                ?.where((item) =>
                                    item.lovType == "ACCOUNTSTATUS" &&
                                    item.value == selectedAccountStatus)
                                .toList();

                            // Print the id of the first item found
                            if (accountStatusList != null &&
                                accountStatusList.isNotEmpty) {
                              context.read<OtherDetailsCubit>().addDataFromUI(
                                    loanLiabilityGuarantor:
                                        LoanLiabilityGuarantor(
                                            accountStatus: accountStatusList[0]
                                                .id
                                                .toString(),
                                            accountStatusName:
                                                selectedAccountStatus),
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
                        );
                      }
                      return  CommonTextField(
                        labelText: AppLocalizations.of(context)!.statusOfAccount,
                        enabled: false,
                      );
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
                            child:  CommonButton(
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
                              if (state.loanLiabilityGuarantor?.guarantorName != null &&
                                  state.loanLiabilityGuarantor!.guarantorName!
                                      .isNotEmpty &&
                                  state.loanLiabilityGuarantor!.bankMasterId !=
                                      null &&
                                  state.loanLiabilityGuarantor!.bankMasterId!
                                      .isNotEmpty &&
                                  state.loanLiabilityGuarantor?.loanAmount !=
                                      null &&
                                  state.loanLiabilityGuarantor?.outstanding !=
                                      null &&
                                  state.loanLiabilityGuarantor!.outstanding!
                                      .isNotEmpty &&
                                  state.loanLiabilityGuarantor?.accountStatus !=
                                      null &&
                                  state.loanLiabilityGuarantor!.accountStatus!
                                      .isNotEmpty) {
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<OtherDetailsCubit>()
                                        .addLoanLiabilityGuarantorList(
                                          LoanLiabilityGuarantor(
                                            guarantorName: state
                                                .loanLiabilityGuarantor
                                                ?.guarantorName,
                                            bankMasterId: state
                                                .loanLiabilityGuarantor
                                                ?.bankMasterId,
                                            bankName: state
                                                .loanLiabilityGuarantor
                                                ?.bankName,
                                            accountStatusName: state
                                                .loanLiabilityGuarantor
                                                ?.accountStatusName,
                                            accountStatus: state
                                                .loanLiabilityGuarantor
                                                ?.accountStatus,
                                            loanAmount: state
                                                .loanLiabilityGuarantor
                                                ?.loanAmount,
                                            outstanding: state
                                                .loanLiabilityGuarantor
                                                ?.outstanding,
                                            listId: uuid.v4(),
                                          ),
                                        );

                                    Navigator.pop(context);
                                  },
                                  child:  CommonButton(
                                    buttonName: AppLocalizations.of(context)!.save,
                                  ),
                                );
                              }

                              return  CommonButton(
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
