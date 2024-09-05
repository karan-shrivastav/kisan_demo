import 'package:flutter/material.dart';
import '../../../../common_button.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../widget/loan_apply_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcceptAndSaveSecondScreen extends StatelessWidget {
  static const routeName = 'accept-and_save-second-screen';
  const AcceptAndSaveSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextWidget(
                      text: 'Congratulations!...',
                      textColor: AppColors.greenColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppTextWidget(
                      text: 'THE BARODA CENTRAL CO-OPERATIVE BANK LTD.',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    AppTextWidget(
                      text: 'BARODA Branch One',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'Application ID',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        textColor: AppColors.greyTextColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'AP-2722059619886575',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        textColor: AppColors.textBlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'Scheme',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        textColor: AppColors.greyTextColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'KCC-CROP',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        textColor: AppColors.textBlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'Type of Credit Facility',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        textColor: AppColors.greyTextColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'Working Capital',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        textColor: AppColors.textBlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: 'Cost of Cultivation',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                            AppTextWidget(
                              text: '37,78,45,53,900',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text:
                                  'Post Harvest/Household Expence/Consumption',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                            AppTextWidget(
                              text: '37,78,45,53,900',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Icons.currency_rupee),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: 'Farm Maintenance',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: AppColors.greyTextColor,
                            ),
                            AppTextWidget(
                              text: '37,78,45,53,900',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              textColor: AppColors.textBlackColor,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          color: AppColors.textColorPrimary,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text:
                                    'KCC Limit for first year(rounded up to the nearest 100)',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
                                textColor: AppColors.textColorPrimary,
                              ),
                              AppTextWidget(
                                text: '37,78,45,53,900',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                textColor: AppColors.textColorPrimary,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
                    child: const CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: 'CANCEL',
                      borderColor: AppColors.secondOutLineColor,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: const CommonButton(
                    buttonName: 'ACCEPT AND SAVE',
                  ),
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
