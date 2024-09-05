import 'package:ekisan_credit/bloc/loan_count/loan_count_bloc.dart';
import 'package:ekisan_credit/bloc/loan_count/loan_count_state.dart';
import 'package:ekisan_credit/view/viewProfile/screens/view_personal_information_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/check_ekyc/check_ekyc_bloc.dart';
import '../../../bloc/check_ekyc/check_ekyc_event.dart';
import '../../../bloc/check_ekyc/check_ekyc_state.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../land/screen/add_land_screen.dart';
import '../../land/screen/view_land_details_screen.dart';
import '../../profile/screens/profile_bottom_sheet.dart';
import '../../viewProfile/screens/view_personal_information_screen.dart';
import 'incomplete_loan_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanScreenWidget extends StatefulWidget {
  const LoanScreenWidget({super.key});

  @override
  State<LoanScreenWidget> createState() => _LoanScreenWidgetState();
}

class _LoanScreenWidgetState extends State<LoanScreenWidget> {
  bool isIncompleteLoan = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 52,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 AppTextWidget(
                  text: AppLocalizations.of(context)!.ekisanCredit,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.greenColor,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const ProfileBottomSheet();
                      },
                    );
                  },
                  child: const Icon(
                    Icons.account_circle_outlined,
                    size: 20,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                if (isIncompleteLoan) ...[
                  const IncompleteLoanCard(),
                  const SizedBox(
                    height: 40,
                  ),
                ],
                BlocBuilder<CheckEkyCBloc, CheckEkyCState>(
                  builder: (BuildContext context, state) {
                    if (state is CheckEkyCStateSuccess) {
                      if (state.checkKycResponseModel.data?.kyc != true) {
                        return IncompleteLoanCard(
                          badgeIcon: Icons.badge_outlined,
                          badgeText: AppLocalizations.of(context)!.aadhaar,
                          isCloseButton: true,
                          headingText: AppLocalizations.of(context)!.linkAadhaarCardForBetterLoan,
                          descriptionText:
                              AppLocalizations.of(context)!.itIsOptionalProcedureForYourSmoother,
                          linkText: AppLocalizations.of(context)!.link,
                          onLinkTap: () {
                            if (kDebugMode) {
                              print("Hii");
                            }
                          },
                        );
                      }
                      return Container();
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: 150.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.yellowBackGroundColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                 Row(
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.dashboard,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: BlocBuilder<LoanCountBloc, LoanCountState>(
                    builder: (BuildContext context, LoanCountState state) {
                      if (state is GetLoanCountSuccess) {
                        // Filter out the "Total Application" data
                        final filteredDataList = state
                            .loanCountResponseModel.dataList
                            ?.where((loanData) =>
                                loanData.statusName != "Total Application")
                            .toList();

                        final filteredDataListOfTotal = state
                            .loanCountResponseModel.dataList
                            ?.where((loanData) =>
                                loanData.statusName == "Total Application")
                            .toList();

                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.yellowBackGroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextWidget(
                                    text: filteredDataListOfTotal
                                            ?.first.statusName ??
                                        '',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  AppTextWidget(
                                    text: filteredDataListOfTotal
                                            ?.first.totalCount
                                            .toString() ??
                                        '0',
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: filteredDataList?.length ?? 0,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final loanData = filteredDataList?[index];

                                return Column(
                                  children: [
                                    if (loanData != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          mainAxisAlignment: index.isOdd
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.9,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: loanData.statusName ==
                                                        'Rejected By Branch'
                                                    ? AppColors
                                                        .redBackgroundColor
                                                    : AppColors
                                                        .backgroundGreenLightColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (index.isEven) ...[
                                                    Expanded(
                                                      child: AppTextWidget(
                                                        text: loanData
                                                                .statusName ??
                                                            '',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    AppTextWidget(
                                                      text: loanData.totalCount
                                                              ?.toString() ??
                                                          '0',
                                                      fontSize: 36,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                  if (index.isOdd) ...[
                                                    AppTextWidget(
                                                      text: loanData.totalCount
                                                              ?.toString() ??
                                                          '0',
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20),
                                                          child: AppTextWidget(
                                                            text: loanData
                                                                    .statusName ??
                                                                '',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DashboardModel {
  final String? text;
  final String? numberValue;

  DashboardModel({this.numberValue, this.text});
}
