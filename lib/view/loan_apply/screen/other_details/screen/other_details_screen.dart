import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/loan_apply/screen/immovable_assets/screen/crop_laon_form_immovable_assets_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../cubit/model/other_details_cubit_model.dart';
import '../../../../../utils/text_input_formate.dart';
import '../../../widget/loan_apply_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFormOtherDetailsScreen extends StatefulWidget {
  static const routeName = "crop-loan-form-other-details";

  const CropLoanFormOtherDetailsScreen({super.key});

  @override
  State<CropLoanFormOtherDetailsScreen> createState() =>
      _CropLoanFormOtherDetailsScreenState();
}

class _CropLoanFormOtherDetailsScreenState
    extends State<CropLoanFormOtherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final otherDetailsCubit = context.read<OtherDetailsCubit>();

    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.otherDetails,
              fontSize: AppTextSize.contentSize22,
              fontWeight: FontWeight.w400,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text:  AppLocalizations.of(context)!.lastYearAnnualIncome,
                          textColor: const Color(0xFF191D17),
                          fontSize: AppTextSize.contentSize16,
                          fontWeight: FontWeight.w400,
                        ),
                        const AppTextWidget(
                          text: "2023-24",
                          fontWeight: FontWeight.w500,
                          fontSize: AppTextSize.contentSize11,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.agricultureIncome,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText: AppLocalizations.of(context)!.pleaseEnterAmount,
                      prefixIcon: Icons.currency_rupee_outlined,
                      length: 20,
                      showPrefixIcon: true, inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],

                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                            loanMasterOtherDetailsRequestPayload:
                                LoanMasterOtherDetailsRequestPayload(
                                    agricultureIncome: value));
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.otherIncome,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText: AppLocalizations.of(context)!.pleaseEnterAmount,
                      length: 20,
                      prefixIcon: Icons.currency_rupee_outlined,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      showPrefixIcon: true,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                            loanMasterOtherDetailsRequestPayload:
                                LoanMasterOtherDetailsRequestPayload(
                                    otherIncome: value));
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.alliedActivity,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText: AppLocalizations.of(context)!.pleaseEnterAmount,
                      prefixIcon: Icons.currency_rupee_outlined,
                      showPrefixIcon: true,
                      length: 20,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                            loanMasterOtherDetailsRequestPayload:
                                LoanMasterOtherDetailsRequestPayload(
                                    alliedIncome: value));
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                 Expanded(
                  child: CommonButton(
                    buttonName: AppLocalizations.of(context)!.cancel,
                    borderColor: AppColors.greenColor,
                    buttonColor: Colors.transparent,
                    buttonTextColor: AppColors.greenColor,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
                    builder: (BuildContext context, OtherDetailsState state) {
                      if (state.loanMasterOtherDetailsRequestPayload
                                  ?.alliedIncome !=
                              null &&
                          state.loanMasterOtherDetailsRequestPayload!.alliedIncome!
                              .isNotEmpty &&
                          state.loanMasterOtherDetailsRequestPayload
                                  ?.agricultureIncome !=
                              null &&
                          state.loanMasterOtherDetailsRequestPayload!
                              .agricultureIncome!.isNotEmpty &&
                          state.loanMasterOtherDetailsRequestPayload
                                  ?.otherIncome !=
                              null &&
                          state.loanMasterOtherDetailsRequestPayload!
                              .otherIncome!.isNotEmpty) {
                        return InkWell(
                          onTap: () {

                            Navigator.pushNamed(context,
                                CropLoanFormImmovableAssetsScreen.routeName);

                            if (kDebugMode) {
                              print(otherDetailsCubit
                                .state.loanMasterOtherDetailsRequestPayload
                                ?.toJson());
                            }


                          },
                          child:  CommonButton(
                            buttonName: AppLocalizations.of(context)!.next,
                          ),
                        );
                      }
                      return CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                        buttonColor: AppColors.grayColor,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
