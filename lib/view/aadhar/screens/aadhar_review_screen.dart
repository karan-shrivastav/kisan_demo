import 'package:ekisan_credit/common_button.dart';
import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../widgets/review_card_widget.dart';
import '../widgets/title_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AadharReviewScreen extends StatefulWidget {
  static const routeName = '/aadhar-review-screen';
  const AadharReviewScreen({super.key});

  @override
  State<AadharReviewScreen> createState() => _AadharReviewScreenState();
}

class _AadharReviewScreenState extends State<AadharReviewScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.greenColor,
                  ),
                ),
                 AppTextWidget(
                  text: AppLocalizations.of(context)!.reviewChanges,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.textBlackColor,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.help_outline_outlined,
                    size: 24,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const AppTextWidget(
              text: 'some small text for user replacement data',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 65),
              height: 48,
              decoration: BoxDecoration(
                  color: AppColors.yellowBackGroundColor,
                  borderRadius: BorderRadius.circular(100)),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.fromSystem,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    endIndent: 0,
                    color: AppColors.secondOutLineColor,
                  ),
                  AppTextWidget(
                    text:  AppLocalizations.of(context)!.fromAadhar,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.fullName,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: 'Mr. Dhanjay sharma',
                      secondTitle: 'Mr. Dhanjay sharma',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.dateOfBirth,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: '12/12/1999',
                      secondTitle: '12/12/1999',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.gender,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: 'Male',
                      secondTitle: 'Male',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title: AppLocalizations.of(context)!.address,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: '7 km Farm, lorem ipsum society',
                      secondTitle: '7 km Farm, lorem ipsum society',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.village,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: 'Lucknow',
                      secondTitle: 'Lucknow',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.district,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: 'Lucknow',
                      secondTitle: 'Lucknow',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.state,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: 'Uttar Pradesh',
                      secondTitle: 'Uttar Pradesh',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     TitleContainer(
                      title:  AppLocalizations.of(context)!.pinCode,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReviewCardWidget(
                      firstTitle: '226065',
                      secondTitle: '226065',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.greenColor,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: AppTextWidget(
                            text:
                                'By clicking here, I acknowledge that I have read, understood, and agree to abide by the terms and conditions.',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
             CommonButton(
              buttonName:  AppLocalizations.of(context)!.next,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
