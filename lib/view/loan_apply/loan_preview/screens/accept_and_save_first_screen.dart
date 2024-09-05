import 'package:ekisan_credit/bloc/loan_preview/loan_details_basic/loan_details_preview_bloc.dart';
import 'package:ekisan_credit/bloc/loan_preview/loan_details_basic/loan_details_preview_state.dart';
import 'package:ekisan_credit/bloc/submit_laon_request/submit_loan_request_state.dart';
import 'package:ekisan_credit/cubit/about_laon_detail/about_laon_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/submit_laon_request/submit_loan_request_bloc.dart';
import '../../../../bloc/submit_laon_request/submit_loan_request_event.dart';
import '../../../../common_button.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import '../../../../utils/money_formater.dart';
import '../../../home/screens/home_screen.dart';
import '../../widget/loan_apply_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcceptAndSaveFirstScreen extends StatelessWidget {
  static const routeName = 'accept-and_save-first-screen';

  const AcceptAndSaveFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CurrencyFormatter currencyFormatter = CurrencyFormatter();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
              pageNumber: 5,
              percentageFirst: 100,
              percentageSecond: 100,
              percentageThird: 100,
              percentageFourth: 50,
            ),
            AppTextWidget(
              text: AppLocalizations.of(context)!.inPrincipleSanction,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: BlocBuilder<LoanDetailsNewPreviewBloc,
                  LoanDetailsNewPreviewState>(
                builder:
                    (BuildContext context, LoanDetailsNewPreviewState state) {
                  if (state is LoanDetailsNewPreviewSuccess) {
                    final cropData = state.loanDetailsNewPreviewResponseModel
                        .data?.loanDetailMapper;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          AppTextWidget(
                            text: AppLocalizations.of(context)!.congratulations,
                            textColor: AppColors.greenColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const AppTextWidget(
                            text: 'THE BARODA CENTRAL CO-OPERATIVE BANK LTD.',
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                          ),
                          const AppTextWidget(
                            text: 'BARODA Branch One',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!.applicationId,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: 'AP-2722059619886575',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!.scheme,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: 'KCC-CROP',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!
                                  .typeOfCreditFacility,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text:
                                  AppLocalizations.of(context)!.workingCapital,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.currency_rupee),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!
                                        .costOfCultivation,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.greyTextColor,
                                  ),
                                  AppTextWidget(
                                    text: currencyFormatter
                                        .formatCurrency(cropData?.firstAmount),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.textBlackColor,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.currency_rupee),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!
                                        .postHarvest,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.greyTextColor,
                                  ),
                                  AppTextWidget(
                                    text: currencyFormatter
                                        .formatCurrency(cropData?.secondAmount),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.textBlackColor,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.currency_rupee),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!
                                        .farmMaintenance,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.greyTextColor,
                                  ),
                                  AppTextWidget(
                                    text: currencyFormatter
                                        .formatCurrency(cropData?.thirdAmount),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.textBlackColor,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee,
                                color: AppColors.textColorPrimary,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!
                                        .kccLimitForFirstYear,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.start,
                                    textColor: AppColors.textColorPrimary,
                                  ),
                                  AppTextWidget(
                                    text: currencyFormatter
                                        .formatCurrency(cropData?.totalAmount),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                    textColor: AppColors.textColorPrimary,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text:
                                  AppLocalizations.of(context)!.ratePerInterest,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!.loanInterest,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!.repayment,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              // width: MediaQuery.of(context).size.width / 2,
                              child: AppTextWidget(
                                text: AppLocalizations.of(context)!.twelveMonth,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,
                                textColor: AppColors.textBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: AppLocalizations.of(context)!.cancel,
                      borderColor: AppColors.secondOutLineColor,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: BlocConsumer<SubmitLoanRequestBloc,
                        SubmitLoanRequestState>(
                  builder:
                      (BuildContext context, SubmitLoanRequestState state) {
                    return InkWell(
                      onTap: () {
                        final loanInfo =
                            context.read<AboutLoanDetailCubit>().state;
                        final bodyRequest = {"masterId": loanInfo.loanId};
                        context
                            .read<SubmitLoanRequestBloc>()
                            .add(SubmitLoanRequest(bodyRequest: bodyRequest));
                      },
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.acceptAndSave,
                      ),
                    );
                  },
                  listener:
                      (BuildContext context, SubmitLoanRequestState state) {
                    if (state is SubmitLoanRequestNewLoading) {
                      showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          scrollable: true,
                          content: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Center(
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
                    if (state is SubmitLoanRequestNewFail) {
                      Navigator.pop(context);
                    }
                    if (state is SubmitLoanRequestNewSuccess) {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName,
                        (Route<dynamic> route) => false,
                        arguments: {
                          'currentPageIndex': 1, // Example value to pass
                          // Add other key-value pairs as needed
                        },
                      );
                    }
                  },
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
