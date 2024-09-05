import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/loan_preview/loan_guarantor_preview/loan_guarantor_preview_bloc.dart';
import '../../../../bloc/loan_preview/loan_guarantor_preview/loan_guarantor_preview_state.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import '../../../../utils/money_formater.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanPreviewGuarantorScreen extends StatefulWidget {
  const LoanPreviewGuarantorScreen({super.key});

  @override
  State<LoanPreviewGuarantorScreen> createState() =>
      _LoanPreviewGuarantorScreenState();
}

class _LoanPreviewGuarantorScreenState
    extends State<LoanPreviewGuarantorScreen> {
  late List<bool> _isExpandedBorrower;
  late List<bool> _isExpandedLiabilitiesGuarantor;
  late List<bool> _isExpandedGuarantor;
  CurrencyFormatter currencyFormatter = CurrencyFormatter();

  @override
  void initState() {
    // TODO: implement initState
    _isExpandedBorrower = List<bool>.filled(10, false);
    _isExpandedLiabilitiesGuarantor = List<bool>.filled(10, false);
    _isExpandedGuarantor = List<bool>.filled(10, false);
    final loanGuarantorPreviewBloc = context.read<LoanDetailsNewBloc>();

    loanGuarantorPreviewBloc.stream.listen((state) {
      if (state is LoanNewDetailsStateSuccess) {
        if (state.loanNewDetailsResponseModel.data!
            .userLoanLiabilityLiabilitiesMappers!.isNotEmpty) {
          _isExpandedBorrower = List<bool>.filled(
              state.loanNewDetailsResponseModel.data!
                  .userLoanLiabilityLiabilitiesMappers!.length,
              false);
        }
        if (state.loanNewDetailsResponseModel.data!.loanGuarantorMappers!
            .isNotEmpty) {
          _isExpandedGuarantor = List<bool>.filled(
              state.loanNewDetailsResponseModel.data!.loanGuarantorMappers!
                  .length,
              false);
        }
        if (state.loanNewDetailsResponseModel.data!.liablitiyGuarantorMappers!
            .isNotEmpty) {
          _isExpandedLiabilitiesGuarantor = List<bool>.filled(
              state.loanNewDetailsResponseModel.data!.liablitiyGuarantorMappers!
                  .length,
              false);
        }
      }
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanDetailsNewBloc, LoanNewDetailsState>(
      builder: (BuildContext context, LoanNewDetailsState state) {
        if (state is LoanNewDetailsStateSuccess) {
          final borrower = state.loanNewDetailsResponseModel.data
              ?.userLoanLiabilityLiabilitiesMappers;
          final guarantor =
              state.loanNewDetailsResponseModel.data?.loanGuarantorMappers;
          final liabilitiesAsGuarantor =
              state.loanNewDetailsResponseModel.data?.liablitiyGuarantorMappers;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextWidget(
                      text: AppLocalizations.of(context)!
                          .detailsOfExistingLoanAccount,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppTextWidget(
                    text: borrower!.isNotEmpty ? "Yes" : "No",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                itemCount: borrower.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final borrowerData = borrower[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _isExpandedBorrower[index] =
                                  !_isExpandedBorrower[index];
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: borrowerData.branchName ?? ' ',
                                    fontSize: AppTextSize.contentSize12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  AppTextWidget(
                                    text: borrowerData.bankType ?? '',
                                    fontSize: AppTextSize.contentSize16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  AppTextWidget(
                                    text: currencyFormatter.formatCurrency(
                                        borrowerData.outstanding),
                                    fontSize: AppTextSize.contentSize14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: _isExpandedBorrower[index],
                          child: Container(
                            color: AppColors.backGroundColor,
                            child: Column(
                              children: [
                                const Divider(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .bankType,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: borrowerData.bankType ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .loanPurpose,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: borrowerData.loanPurpose ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .securityOffered,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text:
                                            borrowerData.securityOfferedName ??
                                                '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .statusOfAccount,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: borrowerData.accountStatusName ??
                                            '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          ))
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextWidget(
                      text: AppLocalizations.of(context)!.guarantorOfferedIfAny,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppTextWidget(
                    text: guarantor!.isNotEmpty ? "Yes" : "No",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.greyTextColor,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                itemCount: guarantor.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final guarantorData = guarantor[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _isExpandedLiabilitiesGuarantor[index] =
                                  !_isExpandedLiabilitiesGuarantor[index];
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextWidget(
                                text: guarantorData.guarantorName ?? ' ',
                                fontSize: AppTextSize.contentSize16,
                                fontWeight: FontWeight.w400,
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: _isExpandedLiabilitiesGuarantor[index],
                          child: Container(
                            color: AppColors.backGroundColor,
                            child: Column(
                              children: [
                                const Divider(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .mobileNumber,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: guarantorData.mobileNumber ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.age,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text:
                                            guarantorData.age.toString() ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .netWorthInLakh,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: currencyFormatter.formatCurrency(
                                            guarantorData.netWorth),
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .occupation,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text:
                                            guarantorData.occupationName ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          AppTextWidget(
                                            text: AppLocalizations.of(context)!
                                                .residentialAddress,
                                            fontSize: AppTextSize.contentSize16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      AppTextWidget(
                                        text: guarantorData.address ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          ))
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextWidget(
                      text: AppLocalizations.of(context)!.liabilitiesAsGuarantor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppTextWidget(
                    text: liabilitiesAsGuarantor!.isNotEmpty ? "Yes" : 'No',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.greyTextColor,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                itemCount: liabilitiesAsGuarantor.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final liabilitiesAsGuarantorData =
                      liabilitiesAsGuarantor[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _isExpandedGuarantor[index] =
                                  !_isExpandedGuarantor[index];
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextWidget(
                                text:
                                    liabilitiesAsGuarantorData.guarantorName ??
                                        '',
                                fontSize: AppTextSize.contentSize16,
                                fontWeight: FontWeight.w400,
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isExpandedGuarantor[index],
                        child: Container(
                          color: AppColors.backGroundColor,
                          child: Column(
                            children: [
                              const Divider(
                                height: 1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, right: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .bankType,
                                      fontSize: AppTextSize.contentSize16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text:
                                          liabilitiesAsGuarantorData.bankType ??
                                              '',
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppTextSize.contentSize12,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 40, top: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .nameOfBank,
                                      fontSize: AppTextSize.contentSize16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text:
                                          liabilitiesAsGuarantorData.bankName ??
                                              '',
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppTextSize.contentSize12,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 40, top: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text:
                                          AppLocalizations.of(context)!.amount,
                                      fontSize: AppTextSize.contentSize16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: currencyFormatter.formatCurrency(
                                          liabilitiesAsGuarantorData.loanAmount
                                              .toDouble()),
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppTextSize.contentSize12,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 40, top: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .balanceOutStanding,
                                      fontSize: AppTextSize.contentSize16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: currencyFormatter.formatCurrency(
                                          liabilitiesAsGuarantorData
                                              .outstanding),
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppTextSize.contentSize12,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
